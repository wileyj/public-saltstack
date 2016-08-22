#!/bin/bash
#
# Plugin to check free swap
# using check_by_ssh
# by Markus Walther (voltshock@gmx.de)
# The script needs a working check_by_ssh connection and needs to run on the client to check it
#
# Command-Line for check_by_ssh
# command_line    $USER1$/check_by_ssh -H $HOSTNAME$ -p $ARG1$ -C "$ARG2$ $ARG3$ $ARG4$ $ARG5$ $ARG6$"
#
# Command-Line for service (example)
# check_by_ssh!82!/nagios/check_swap.sh!50!20
#
##########################################################
#
# Modified to support returning OK if cache+buffer >= swap total
#      muellerpe 20111003
#
##########################################################
case $1 in
  --help | -h )
        echo "Usage: check_swap [warn] [crit]"
        echo " [warn] and [crit] as int"
        echo " Example: check_swap 20 10"
        exit 3
	;;
  * )
	;;
esac

logger=`which logger`

warn=`echo $1 | cut -f 1 -d '%'` # remove % if it exists
crit=`echo $2 | cut -f 1 -d '%'` # remove % if it exists

if [ ! "$1" -o ! "$2" ]; then
        echo "Usage: check_swap [warn] [crit]"
        echo " [warn] and [crit] as int"
        echo " Example: check_swap 20 10"
        echo "Unknown: Options missing: using default (warn=20, crit=10)"
        warn=`echo $((20))`
        crit=`echo $((10))`
fi

fullswap=`free | grep Swap | sed -r 's/\ +/\ /g' | cut -d \  -f 2`
freeswap=`free | grep Swap | sed -r 's/\ +/\ /g' | cut -d \  -f 4`
cache=`free | grep "Mem" | awk '{print $7}'`
buffers=`free | grep "Mem" | awk '{print $6}'`
fullmem=`free | grep ^Mem | awk '{print $2}'`
freemem=`free | grep ^Mem | awk '{print $4}'`

if [ "$fullswap" -eq "0" -a "$freeswap" -eq "0" ]; then
    echo "CRITICAL: no values for swap. Looks like swap may be off. Please consult the documentation."
        exit 2
    fi

if [ "$warn" -lt "$crit" -o "$warn" -eq "$crit" ]; then
   echo "UNKNOWN: [warn] must be larger than [crit]"
        exit 3
fi

grandtotal=`echo $(( ($fullmem + $fullswap) ))`
totalfree=`echo $(( ($freemem + $freeswap + $cache + $buffers) ))`
freepct=`echo $(( ($totalfree * 100) / $grandtotal ))`

#use=`echo $(( ($free * 100) / $full ))`
#use2=`echo $(( ($cache + $buffers) ))`

if [ "$freepct" -gt "$warn" -o "$freepct" -eq "$warn" ]; then
        echo "OK: $freepct% ($totalfree kB) free memory+swap"
        exit 0
elif [ "$freepct" -lt "$warn" -a "$freepct" -gt "$crit" ]; then
        echo "WARNING: $freepct% ($totalfree kB) free memory+swap"
        exit 1
elif [ "$freepct" -eq "$crit" -o "$freepct" -lt "$crit" ]; then
        echo "CRITICAL: $freepct% ($totalfree kB) free memory+swap"
	$logger -p crit "CRITICAL: $freepct% ($totalfree kB) free memory+swap"
        exit 2
else
        echo "Unknown"
        exit 3
fi
