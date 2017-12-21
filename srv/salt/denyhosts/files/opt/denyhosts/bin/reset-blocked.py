#!/usr/bin/env python
import argparse
import os
import socket
import sys
import fileinput
import re

abspath = os.path.abspath(__file__)
dname = os.path.dirname(abspath)
app_prefix = os.path.dirname(os.path.dirname(abspath))
os.chdir(dname)
cwd = os.getcwd()

files = [
    app_prefix + "/data/hosts",
    app_prefix + "/data/hosts-restricted",
    app_prefix + "/data/hosts-root",
    app_prefix + "/data/hosts-valid",
    app_prefix + "/data/users-hosts",
    app_prefix + "/data/users-hosts",
    app_prefix + "//data/users-invalid",
    "/etc/hosts.deny"
]


def parse_file(file, ip):
    for line in fileinput.input(file, inplace=True):
        denyhosts_line = line.strip()
        if not denyhosts_line or denyhosts_line.startswith('#'):
            continue
        else:
            if re.search(ip, line) is None:
                print denyhosts_line
    return True


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument(
        '--ip',
        nargs='?',
        metavar='',
        default="",
        required=True,
        help="IP Address",
    )
    args = parser.parse_args()
    try:
        socket.inet_aton(args.ip)
    except socket.error:
        print "Invalid IP. Exiting"
        sys.exit(-1)
    print "Resetting Blocked IP: %s" % (args.ip)
    for file in files:
        if os.path.exists:
            print "Checking for %s in %s" % (args.ip, file)
            parse_file(file, args.ip)
        else:
            print "Missing File (%s)" % (file)
