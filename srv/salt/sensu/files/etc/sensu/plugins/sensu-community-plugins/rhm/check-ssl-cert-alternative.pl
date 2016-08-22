#!/usr/bin/perl -w
# SSL Certificate check for Nagios
# Written by Tim Gibbon (nagios@reversemidastouch.com)
# Last Modified: 17-Sep-2006
#
# Description:
#
# This plugin will check the expiry date of a remote SSL
# certificate and will warn if the cert is due to expire.
#
$main::VERSION=0.01;

## LICENCE ###########################################################
## This program is free software; you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 2 of the License, or
## (at your option) any later version.
##
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
##
## You should have received a copy of the GNU General Public License
## along with this program; if not, write to the Free Software
## Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
## END LICENCE #######################################################

###############################################################################
###Add the following to your nagios config where <hostnametocheck> is the
###fully qualified domain name of the certificate to inspect
#define service{
#        use                             generic-service
#        host_name                       <hostnametocheck>
#        service_description             Server Certs
#        is_volatile                     0
#        check_period                    24x7
#        max_check_attempts              4
#       normal_check_interval           1440
#        retry_check_interval            5
#        contact_groups                  linux-admins
#        notification_interval           1440
#        notification_period             24x7
#        notification_options            c,r
########check_command                   check-ssl-cert!warningdays!criticaldays
#        check_command                   check-ssl-cert!703!10

#define host{
#        use                     generic-host
#        host_name               <hostnametocheck>
#        address                 <hostnametocheck>
#        max_check_attempts      4
#        notification_interval   480
#        notification_period     workhours
#        check_command           check-ssl-cert
#        contact_groups          linux-admins
#        }
###############################################################################
###############################################################################
#checkcommands.cfg addition
#define command{
#        command_name    check-ssl-cert
#        command_line    $USER1$/check_ssl_cert_alternative.pl -H $HOSTADDRESS$ -w $ARG1$ -c
#$ARG2$
#        }




my $exit_status;
use strict;
use Getopt::Std;
use File::Basename;
use Time::Local;

# Location of the openssl command (if not in path)
my $openssl_path="/usr/bin/openssl";
my $default_warning=30;   #Time before we get ORANGE alert in days
my $default_critical=14;  #Time before we get RED alert in days

# Don't change anything below here

# Nagios return codes
my $STATE_OK=0;
my $STATE_WARNING=1;
my $STATE_CRITICAL=2;
my $STATE_UNKNOWN=3;
my $STATE_DEPENDENT=4;
my $progname=basename $0;

my %months= ( 'Jan'=> 0, 'Feb' => 1, 'Mar' => 2, 'Apr' =>3, 'May' =>4, 'Jun' =>5, 'Jul' =>6, 'Aug' =>7, 'Sep' =>8, 'Oct' =>9, 'Nov' =>10, 'Dec' =>11);

unless (-x $openssl_path ){
        print "UNKNOWN: $openssl_path not found or is not executable by the nagios user\n";
        my $exitstatus=$STATE_UNKNOWN;
        exit $exitstatus;
}

my ($hoststring,$warning,$critical)=check_usage ($default_warning,$default_critical,$main::VERSION);


#open (DEBUG, ">/tmp/bobbins.log");
#print (DEBUG "Running $progname against host $hoststring using $warning/$critical \n");
#close (DEBUG);

my ($certtimeleft,$certenddate)=run_openssl_compare_times();


#############################################
#print "$hoststring $certtimeleft Days left\n";
print "$hoststring expires on $certenddate\n";
#############################################

#Make the comparisons with our incoming/default params#
if ($certtimeleft <= $critical){
#    print ("Exiting critical\n");
    exit $STATE_CRITICAL;
} elsif ($certtimeleft <= $warning ){
#    print ("Exiting warning\n");
    exit $STATE_WARNING;
} else {
#    print ("Exiting ok\n");
    exit $STATE_OK;
}
#######################################################
# End of program
#######################################################

######Should never get here
exit $STATE_UNKNOWN;
###########################


################################################################################
sub check_usage {

    my $alert_warning=$_[0];
    my $alert_critical=$_[1];
    my $version=$main::VERSION;


my %cmd_options;
getopt ("vhwcH",\%cmd_options);


if ($cmd_options{h}){
print_usage($version);
}

unless ($cmd_options{H}){

print_usage($version);
}


my $hostname_port_number;

if ($cmd_options{H} =~ /([\w+\.*]+\:\d+)/){
    $hostname_port_number=$1;
#    print ("Hostname = $hostname_port_number\n");
} elsif ($cmd_options{H} !~ /\d+/){
    $hostname_port_number=$cmd_options{H}.":443";
#    print ("Hostname = $hostname_port_number\n");
} else {
    print("You must provide a hostname in the format hostname:portnumber\n");
    print_usage();
}



if (($cmd_options{w})&&($cmd_options{w} =~ /\d+/)){
    $alert_warning=$cmd_options{w};
#    print ("Warning limit defined, using $alert_warning\n");
}

if (($cmd_options{c})&&($cmd_options{c} =~ /\d+/)){
    $alert_critical=$cmd_options{c};
#    print ("Critical limit defined, using $alert_critical\n");
}

#    print ("Ending check_usage - warning = $alert_warning, critical = $alert_critical\n");

return($hostname_port_number,$alert_warning,$alert_critical);


}#End sub
################################################################################


sub print_usage {

    my $progname =basename($0);
    my $version=$_[0];
    print ("$0 $version\n");
    print ("Syntax:\n");
    print ("$progname -H <hostname>[:port] [-w <warning time in days>] [-c <critical time in days>]\n");
    my $exitstatus=$STATE_UNKNOWN;
    exit $exitstatus;
}


##############################################################################

sub run_openssl_compare_times {

my @openssl_output;

open (CMD,"echo | $openssl_path s_client -connect $hoststring 2>/dev/null| $openssl_path x509 -noout -enddate  |") or print_usage() ;

while (<CMD>){
chomp;
push (@openssl_output,"$_");
}
close (CMD);
################################################################################

###############################################################################
my ($junk,$enddate);
foreach (@openssl_output){
next unless /notAfter/;
($junk,$enddate) = split (/\=/);
}
###############################################################################

#At this stage we have the data stored in enddate, we just need to break
#it up and compare to today

####Split into component parts and place into epoch time
my ($month,$day,$time,$year,$tz)=split(/\s+/,$enddate);
my ($hour,$min,$sec)=split(/\:/,$time);
my $expiration_time=timegm($sec, $min, $hour, $day, $months{$month}, $year-1900);
########################################################


################Make the comparison####################################
my $today=time;
my $timeleft=int(($expiration_time-$today)/(86400)); #86400 secs in day
return ($timeleft,$enddate);
#######################################################################
}#End sub

