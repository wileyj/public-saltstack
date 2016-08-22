#!/bin/bash

LOGS_ROOT="/var/log/nginx"
LOGS_ARCHIVE="$LOGS_ROOT/archive"

if [ ! -d $LOGS_ARCHIVE ]
then
    mkdir -p $LOGS_ARCHIVE
fi

CUR_HOST=`hostname -s`
TODAY=`date +%Y-%m-%d`
ARCHIVE_HOST=""
SKIP_RSYNC=1
DATE=$(date '+%Y%m%d%H%M%S')
SEARCHDATE=$(date '+%Y%m%d')

if [ $1 ] ; then
    LOGDAYS="+$1"
else
    echo "Defaulting for a 14 day retention on archived logs."
    LOGDAYS="+14"
fi

for i in `find $LOGS_ROOT -maxdepth 1 -type f -printf "%f\n" `
do
    mv $LOGS_ROOT/$i $LOGS_ARCHIVE/$i.$DATE
done
for i in `find $LOGS_ARCHIVE -type f -mtime $LOGDAYS`
do
    rm -rf $i
done
kill -USR1 `cat /var/run/nginx.pid`
sleep 1
cd $LOGS_ARCHIVE && gzip *[0-9]
exit