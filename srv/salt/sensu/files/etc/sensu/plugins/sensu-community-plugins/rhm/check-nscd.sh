#!/bin/bash
# Check NSCD health 
# 1 -- If NSCD is using too much CPU, clear entries & restart.
# 2 -- If NSCD is using too much memory, clear entries & restart.
# 3 -- If NSCD is using too many files, it's likely gone bad.  clear entries & restart.

# Adjust as needed.  These values are in %
PERCENT_BAD_CPU="80"
PERCENT_BAD_MEM="20"

# this value is # of files NSCD is using
BAD_FILES="400"

# Import codes, if we can
if [ -f /opt/nagios/libexec/utils.sh ]; then
	. /opt/nagios/libexec/utils.sh
else
	STATE_OK=0
	STATE_WARNING=1
	STATE_CRITICAL=2
	STATE_UNKNOWN=3
	STATE_DEPENDENT=4
fi

if [ ! -f /usr/sbin/lsof ]; then
	echo "UNKNOWN : /usr/sbin/lsof is missing"
	exit ${STATE_UNKNOWN}
fi

LOGGER=`which logger`

# PID of NSCD
if [ -f /var/run/nscd/nscd.pid ]; then
	NSCD_PID=`cat /var/run/nscd/nscd.pid`
else
	NSCD_PID=`ps -ef | grep nscd | grep -v grep | grep "/usr/sbin/nscd" | grep -v "\-i" | awk '{print $2}'`
	if [ -z $NSCD_PID ]; then
		echo "CRITICAL: NSCD_PID not found.  Is NSCD running?"
		exit ${STATE_CRITICAL}
	fi
fi

# Get current usage
NSCD_CPU=`ps aux | grep ${NSCD_PID} | grep -v lsof | grep -v grep | awk '{print $3}'`
NSCD_MEM=`ps aux | grep ${NSCD_PID} | grep -v lsof | grep -v grep | awk '{print $4}'`

# Main

# 1 cpu check
COMPARE=`echo "${NSCD_CPU} >= ${PERCENT_BAD_CPU}" | /usr/bin/bc`
if [ "$COMPARE" -eq "1" ]; then
	echo "NSCD at ${NSCD_CPU}% cpu usage, error level is ${PERCENT_BAD_CPU}%. Eventhandler will run"
	${LOGGER} -p crit "NSCD at ${NSCD_CPU}% cpu usage, error level is ${PERCENT_BAD_CPU}%. Eventhandler will run"
	exit ${STATE_CRITICAL}
fi

# 2 memory check
COMPARE=`echo "${NSCD_MEM} >= ${PERCENT_BAD_MEM}" | /usr/bin/bc`
if [ "$COMPARE" -eq "1" ]; then
	echo "NSCD at ${NSCD_MEM}% mem usage, error level is ${PERCENT_BAD_MEM}%. Eventhandler will run"
	${LOGGER} -p crit "NSCD at ${NSCD_MEM}% mem usage, error level is ${PERCENT_BAD_MEM}%. Eventhandler will run"
	exit ${STATE_CRITICAL}
fi

# 3 file descriptors check
FD=`sudo /usr/sbin/lsof -b -p ${NSCD_PID} 2>/dev/null | /usr/bin/wc -l`
if ! [[ "${FD}" =~ ^[0-9]+$ ]]; then
		exec >&2; echo "WARNING: file descriptors failing likely due to hanging LSOF command from NSCD"
		exit ${STATE_WARNING}
else
	COMPARE=`echo "${FD} >= ${BAD_FILES}" | /usr/bin/bc`
	if [ "$COMPARE" -eq "1" ]; then
		echo "NSCD at ${FD} # of files, error level is ${BAD_FILES}. Eventhandler will run."
		${LOGGER} -p crit "NSCD at ${FD} # of files, error level is ${BAD_FILES}. Eventhandler will run."
		exit ${STATE_CRITICAL}
	fi
fi

echo "OK - no errors detected in NSCD"
exit ${STATE_OK}
