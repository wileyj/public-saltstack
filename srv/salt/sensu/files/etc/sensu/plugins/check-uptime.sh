#!/bin/bash
#
# Check uptime.  Nagios alert on conditions we don't like.
#
# Critdays & warndays are configurable.  if $1 and $2, then use those values.  Otherwise, use defaults
# $1 CRITDAYS
# $2 WARNDAYS

# needed variables
HOST_NAME=`hostname`
PROGNAME=`basename $0`
PROGPATH=`dirname $0`

# defaults
if [ -n "$1" ]; then
        CRITDAYS=$1
else
        CRITDAYS=900
fi
if [ -n "$2" ]; then
        WARNDAYS=$2
else
        WARNDAYS=800
fi

# Hours
WARNHOURS=24
CRITHOURS=0

# pull in exit states
. $PROGPATH/utils.sh

# calculate time
UPTIME=`gawk -F . '{ print $1 }' /proc/uptime`
MINS=$(($UPTIME/60))
HOURS=$(($MINS/60))
DAYS=$(($HOURS/24))

if [ "$HOURS" -lt "${CRITHOURS}" ]; then
        echo "CRITICAL - ${hostname} has only been up ${HOURS} hours"
        exit $STATE_CRITICAL
elif [ "$HOURS" -lt "${WARNHOURS}" ]; then
        echo "WARNING - ${hostname} has only been up ${HOURS} hours."
        exit $STATE_WARNING
elif [ "$DAYS" -gt "${CRITDAYS}" ]; then
        echo "CRTIICAL - ${hostname} has gone ${DAYS} since reboot"
        exit $STATE_CRITICAL
elif [ "$DAYS" -gt "${WARNDAYS}" ]; then
        echo "WARNING - ${hostname} has gone ${DAYS} since reboot"
        exit $STATE_WARNING
elif [ "${CRITDAYS}" -lt "${WARNDAYS}" ]; then
        echo "UNKNOWN - You've got CRITDAYS - $1 - setup to be less than WARNDAYS - $2"
        exit $STATE_UNKNOWN
else
        echo "OK - ${DAYS} days or ${HOURS} hours uptime"
        exit $STATE_OK
fi