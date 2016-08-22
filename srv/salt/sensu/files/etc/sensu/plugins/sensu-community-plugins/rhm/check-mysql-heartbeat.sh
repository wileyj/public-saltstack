#!/bin/bash

MYSQL="/opt/mysql/product/5.0.77/bin/mysql"

if [ $# != 7 ]; then
  echo "Usage: $0 warn_thresh crit_thresh mysql_user mysql_passwd mysql_ip mysql_port mysql_db"
  exit 2
fi

WARN=$1
CRIT=$2
USER=$3
PASSWORD=$4
IP=$5
PORT=$6
DB=$7

# First check to see that heartbeat table has exactly one row with id=1.  
# Anything different means the table is somehow damaged and an alert 
# should be generated
output=`$MYSQL -s -e "SELECT id FROM heartbeat where id=1" -u$USER -p$PASSWORD -A -h$IP -P$PORT $DB |/bin/grep -v id`
res=$?
if [ $res -ne 0 ]; then
  exit 2
fi

output=`$MYSQL -s -e "SELECT abs(time_to_sec(timediff(ts,now()))) as timedifference FROM heartbeat WHERE id=1" -u$USER -p$PASSWORD -A -h$IP -P$PORT $DB |/bin/grep -v timedifference`
res=$?
if [ $res -ne 0 ]; then
  exit 2
fi

if [ $output -ge $CRIT ]; then
  return=2
elif [ $output -ge $WARN ]; then
  return=1
elif [ $output -lt $WARN ] && [ $output -ge 0 ]; then
  return=0
else
  #unknown condition (should never happen)
  return=2
fi

echo $output
exit $return

