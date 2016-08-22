#! /usr/bin/python

import os
import sys
import subprocess
import getopt
from string import Template
from xml.dom import minidom

# Nagios response codes
STATUS_OK = "0"
STATUS_WARNING = "1"
STATUS_CRITICAL = "2"
STATUS_UNKNOWN = "3"

#Properties to set before run
jmeter_run_home = None

#Jmeter properties
jmeter_run_port = "13042"
jmeter_run_host = "127.0.0.1"
jmeter_run_test_file = "/tmp/CheckPostingInstance.jmx"#Default Test to run
#Jmeter results file name pattern. Will be constructed in init block
jmeter_run_log = "/tmp/result_"

# Jmeter report properties
jmeter_result_internal_properties = ['-Djmeter.save.saveservice.output_format=xml',
                                     '-Djmeter.save.saveservice.assertion_results_failure_message=true',
                                     '-Djmeter.save.saveservice.successful=true',
                                     "-Djmeter.save.saveservice.response_data=true",
                                     "-Djmeter.save.saveservice.response_data.on_error=true"]

# Start up command
jmeter_start_command = '${JMETER_HOME}/bin/jmeter.sh --nongui  --testfile ${TEST_FILE} --logfile=${LOG}'

def main(arguments):
    #Check for preconditions
    init(arguments)
    #Run Jmeter Test
    runCheck()
    #Check results and exist
    checkResults()

##
# function: initialize
# Initialize script variables
##
def init(arguments):
    # get cmdline options
    try:
        opts, args = getopt.getopt(arguments, "H:P:T:J:", ["host=", "port=", "test=", "jmeter="])
    except getopt.GetoptError:
        usage()
        print "UNKNOWN - Error parsing cmd line options."
        sys.exit(STATUS_UNKNOWN)

    global jmeter_run_host
    global jmeter_run_port
    global jmeter_run_test_file
    global jmeter_run_home

    #Parse input arguments
    for opt, arg in opts:
        if opt in ("-H", "--host"):
            #Set Host
            jmeter_run_host = arg
        elif opt in ("-P", "--port"):
            #Set instance port
            jmeter_run_port = int(arg)
        elif opt in ("-T", "--test"):
            #Test file to run
            jmeter_run_test_file = arg
        elif opt in ("-J", "--jmeter"):
            #Jmeter home to run
            jmeter_run_home = arg

    if None in (jmeter_run_host, jmeter_run_port, jmeter_run_test_file, jmeter_run_home):
        usage()
        print "UNKNOWN - Wrong input parameters for script."
        sys.exit(STATUS_UNKNOWN)

    #Check for existence of jmeter
    if not os.path.exists(jmeter_run_home + "/bin/jmeter.sh"):
        usage()
        print "UNKNOWN - Jmeter wasn't found in %s." % jmeter_run_home
        sys.exit(STATUS_UNKNOWN)

    # Check for existing jmeter test
    if not os.path.exists(jmeter_run_test_file):
        usage()
        print "UNKNOWN - Jmeter test file %s doesn't exist." % jmeter_run_test_file
        sys.exit(STATUS_UNKNOWN)

    global jmeter_run_log
    #Set jmeter results file name to /tmp/result-${NAME_OF_TEST}.jtl
    jmeter_run_log += "%s_%s_%s.jtl" % (os.path.splitext(os.path.basename(jmeter_run_test_file))[0], jmeter_run_host, jmeter_run_port)

    # Remove log from previous execution
    if os.path.exists(jmeter_run_log):
        os.remove(jmeter_run_log)

##
# function usage
# Shows help
##
def usage():
    print """
Usage: check_jmeter_test.py -H <Host> -P <Port> -T <Path to jmx test> -J <Jmeter home path >.
Example: check_jmeter_test.py -H 127.0.0.1 -P 12042 -T ./Test.jmx -J /home/zenind/jmeter
"""

##
# function: startJmeter
# Starts Jmeter and runs test
##
def runCheck():
    execCommand = Template(jmeter_start_command).substitute(JMETER_HOME=jmeter_run_home, TEST_FILE=jmeter_run_test_file,
                                                            LOG=jmeter_run_log)

    #Parse program arguments
    args = execCommand.split()

    #Set host and port to run jmeter against
    jmeter_result_system_properties = ["-JSERVER_NAME=%s" % jmeter_run_host, "-JPORT=%s" % jmeter_run_port]

    args[len(args):] = jmeter_result_internal_properties
    args[len(args):] = jmeter_result_system_properties

    #Run jmeter process
    p = subprocess.Popen(args)
    p.communicate()
    returnCode = p.returncode
    if returnCode :
        print "UNKNOWN - Jmeter job ended not correctly. Return code - %s." % returnCode
        sys.exit(STATUS_UNKNOWN)

##
# function: checkResults
# Checks generated jmeter results file for failing requests.
##
def checkResults():
    if not os.path.exists(jmeter_run_log):
        print "UNKNOWN - Error processing jmeter results file. Results file doesn't exist by %s path." % jmeter_run_log
        sys.exit(STATUS_UNKNOWN)

    totalNumberOfRequests = 0
    failedSections = []
    try:
        #Parse jmeter results file. Should be an xml. See -Djmeter.save.saveservice.output_format
        doc = minidom.parse(jmeter_run_log)

        #Get all requests
        httpSamples = doc.getElementsByTagName('httpSample')
        totalNumberOfRequests =  len(httpSamples)
        for httpSample in httpSamples:
            httpStatus = httpSample.getAttribute("s")#Request Status
            if httpStatus == "false":
                requestName = httpSample.getAttribute("lb")#Request Name
                responseCode = httpSample.getAttribute("rc")#Response Code
                responseMessage = httpSample.getAttribute("rm")#Response Message
                responseData = ""
                for childNode in httpSample.childNodes:
                    #Response Data node
                    if childNode.nodeName == "responseData" and childNode.firstChild and childNode.firstChild.nodeValue:
                        #Get Response Data from failing request.
                        responseData = childNode.firstChild.toprettyxml()
                        break
                #Build Failed Request message.
                failedRequestDescription = "Request \"%s\" failed with response code \"%s\" and response message \"%s.\" Reason:\n %s" % (
                requestName, responseCode, responseMessage, responseData)
                failedSections.append(failedRequestDescription)
    except Exception, exception:
        print "CRITICAL - Error parsing Jmeter results file. Reason: %s." % exception
        sys.exit(STATUS_CRITICAL)

    failedRequestsQuantity = len(failedSections)

    if failedRequestsQuantity > 0:
        uniqueFailedSections = ""
        for failedSection in failedSections:
            uniqueFailedSections += " %s " % failedSection
            break
        print "CRITICAL - Number of failure requests = %s. Total Number of requests = %s. First failing request: \n%s" % (
        failedRequestsQuantity, totalNumberOfRequests, uniqueFailedSections)
        sys.exit(STATUS_CRITICAL)
    else:
        print "OK - Status is OK."
        sys.exit(STATUS_OK)


if __name__ == "__main__":
    main(sys.argv[1:])
  