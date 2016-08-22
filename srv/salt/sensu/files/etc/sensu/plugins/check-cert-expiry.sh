#!/bin/bash

OPENSSL="/usr/bin/openssl"

if [ $# != 3 ]; then
	echo "Usage: $0 warn_thresh_days crit_thresh_days cert_file"
	exit 2;
fi

WARN=$1
CRIT=$2
FILE=$3

# verify the critical threshold is smaller than the warning threshold
if [ $WARN -lt $CRIT ]; then
	echo "Usage: $0 warn_thresh_days crit_thresh_days cert_file"
	echo "   warn_thresh_days must be greater than crit_thresh_days"
	exit 2;
fi

NOW=`date +%s`
res=$?
if [ $res -ne 0 ]; then
	echo "date command failed"
        exit 2
fi

# verify the file exists and is readable
if [ ! -r $FILE ]; then
	echo "Invalid cert file $FILE"
	exit 1
fi

# look at the cert
output=`$OPENSSL x509 -in $3 -noout -dates`
res=$?
if [ $res -ne 0 ]; then
        exit 2
fi

# seperate out the start and end dates
startvalid=`echo "$output" |grep "notBefore" |cut -d "=" -f 2-`
res=$?
if [ $res -ne 0 ]; then
        exit 2
fi
endvalid=`echo "$output" |grep "notAfter" |cut -d "=" -f 2-`
res=$?
if [ $res -ne 0 ]; then
        exit 2
fi

# now convert them into unix times
startts=`date +%s --date="$startvalid"`
res=$?
if [ $res -ne 0 ]; then
        exit 2
fi
endts=`date +%s --date="$endvalid"`
res=$?
if [ $res -ne 0 ]; then
        exit 2
fi

# verify current time is newer than certificate start time
if [ $startts -gt $NOW ]; then
	echo "Certificate is not yet valid"
	exit 2
fi

# verify ticket hasn't expired (or is about to expire)
if [ $NOW -gt $endts ]; then
	echo "Certificate has expired"
	exit 2
elif [ $((endts-$NOW)) -lt $(($CRIT*86400)) ]; then
	echo "Certificate expires in $((($endts-$NOW)/86400)) days"
	exit 2
elif [ $((endts-$NOW)) -lt $(($WARN*86400)) ]; then
	echo "Certificate expires in $((($endts-$NOW)/86400)) days"
	exit 1
fi

echo "Certificate expires in $((($endts-$NOW)/86400)) days"
exit 0
