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

usage="$(basename "$0") [-t timeout] [-S secretfile] [-F vcl_file] -T [address]:port
    where:
        -h  show this help text
        t,S,T,F refer to varnishadm"
timestamp=`date +%s`
while getopts ':n:t:S:F:T:d:h' option; do
    case $option in
    t) timeout=$OPTARG
        ;;
    S) secretfile=$OPTARG
        ;;
    F) vcl_file=$OPTARG
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

if [ ! -z $vcl_file ]; then
    varnishd -Cf $vcl_file > /dev/null > 2&>1
    if [ $? -ne "0" ]; then
        echo "Failed parsing vcl file $vcl_file"
        exit $?
    fi
fi

# Done parsing, set up command
VARNISHADM="varnishadm"
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

$VARNISHADM vcl.load "varnish_$timestamp" $vcl_file > /dev/null 2>&1
if [ $? == 0 ]; then
    echo "successfully reloaded vcl $vcl_file"
else
    echo "failed to load new vcl config"
    exit 1
fi

$VARNISHADM vcl.use varnish_$timestamp
if [ $? == 0 ]; then
    echo "successfully activated vcl $vcl_file"
    exit 0
else
    echo "failed to activate new vcl config"
    exit 1
fi