#!/bin/bash
#
# reload active vcl
# Sometimes, vcl_init needs to be re-run by reloading the active vcl.
# For example, a geoip database is loaded in vcl_init. When the database is updated,
# vcl_init needs to be re-run.
#
# This script saves the currently active vcl to a shell variable, and reloads it to varnish
# Wislon Sun
#

usage="$(basename "$0") [-n ident] [-t timeout] [-S secretfile] -T [address]:port
    where:
        -h  show this help text
        -n,t,S,T,F refer to varnishadm"
timestamp=`date +%s`
while getopts ':n:t:S:F:T:d:h' option; do
    case $option in
    n) ident=$OPTARG
        ;;
    t) timeout=$OPTARG
        ;;
    S) secretfile=$OPTARG
        ;;
    T) addressport=$OPTARG
        ;;
    h) echo "$usage"
        exit
        ;;
    :) printf "missing argument for -%s\n" "$OPTARG" >&2
        echo "$usage" >&2
        exit 1
        ;;
    \?) echo "illegal option: -$OPTARG" >&2
        echo "$usage" >&2
        exit 1
        ;;
    esac
done

# Done parsing, set up command
VARNISHADM="varnishadm"
if [ ! -z "$ident" ]; then
    VARNISHADM="$VARNISHADM -n $ident"
fi
if [ ! -z "$timeout" ]; then
    VARNISHADM="$VARNISHADM -t $timeout"
fi
if [ ! -z "$secretfile" ]; then
    VARNISHADM="$VARNISHADM -S $secretfile"
fi
if [ ! -z "$addressport" ]; then
    VARNISHADM="$VARNISHADM -T $addressport"
fi

# Check if we are able to connect at all
if ! $VARNISHADM vcl.list >> /dev/null 2>&1; then
    echo "Unable to run \"$VARNISHADM vcl.list\""
    exit 1
fi

# find current config
current_config=$( $VARNISHADM vcl.list | awk ' /^active/ { print $4 } ' )
# save current config to a variable
vclcontent=` $VARNISHADM vcl.show $current_config | sed 's/["\]/\\\\&/g' | sed ':a;N;$!ba;s/\n/\\\\n/g' `
$VARNISHADM vcl.inline "vreload$timestamp" '"'$vclcontent'"' >> /dev/null 2>&1
vstring=`varnishadm vcl.list|grep "vreload$timestamp"`
# vstring=`varnishadm -n aeroflow vcl.list|grep "vreload$timestamp"`
if [ ! -z "$vstring" ]; then
    $VARNISHADM vcl.use "vreload$timestamp" >> /dev/null 2>&1
    $VARNISHADM vcl.discard $current_config >> /dev/null 2>&1
    echo "successfully reload current vcl config"
    exit 0
else
    echo "failed to save current vcl config"
    exit 1
fi
