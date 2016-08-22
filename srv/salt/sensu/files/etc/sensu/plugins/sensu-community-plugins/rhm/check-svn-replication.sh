#!/bin/sh
################################################################
# Licensed to the Apache Software Foundation (ASF) under one   #
# or more contributor license agreements.  See the NOTICE file #
# distributed with this work for additional information        #
# regarding copyright ownership.  The ASF licenses this file   #
# to you under the Apache License, Version 2.0 (the            #
# "License"); you may not use this file except in compliance   #
# with the License.  You may obtain a copy of the License at   #
#                                                              #
#   http://www.apache.org/licenses/LICENSE-2.0                 #
#                                                              #
# Unless required by applicable law or agreed to in writing,   #
# software distributed under the License is distributed on an  #
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY       #
# KIND, either express or implied.  See the License for the    #
# specific language governing permissions and limitations      #
# under the License.                                           #
################################################################
SVN=/usr/bin/svn
GREP=/bin/grep
CUT=/usr/bin/cut
MASTER_SVN=$1
SLAVE_SVN=$2
#SLACK=2
SLACK=5 # allow a bit of leeway so as to reduce false positives
SLAVE_ERROR=

# /root/.subversion/servers put this at end
# store-plaintext-passwords = no
HOME=/root

# need master & slave svn
if [ $# -gt 1 ]
then
	# make sure we're running on the slave.  the slave will have the pull script
	if [ -f /usr/local/bin/sync_pull_script.sh ]
	then
		# REPO list from sync pull script
		for REPO in `cat /usr/local/bin/sync_pull_script.sh | grep "export REPOS" | head -n 1 | cut -f 2 -d '"'`
		do
    			# get the revision of the master repo
			MASTER_REV=`$SVN --username sysmgr --password p3+$+0r3 info $MASTER_SVN/$REPO | grep -i ^revision | cut -f2 -d ' '`
			# get the revision of the slave repo
			SLAVE_REV=`$SVN --username sysmgr --password p3+$+0r3 info $SLAVE_SVN/$REPO | grep -i ^revision | cut -f2 -d ' ' | sed -e 's/[^0-9]//'`
			# check if the revisions are not equal
			if [ -n $SLAVE_REV ] && [ `expr $SLAVE_REV + $SLACK` -le "$MASTER_REV" ]
			then
				echo "CRITICAL $REPO $SLAVE_ERROR out of sync with $MASTER_SVN (rev: $MASTER_REV)"
				exit 2
			fi
		done
		# REPO list from sync pull script -- neopets special repos edition
		for REPO in `cat /usr/local/bin/sync_pull_script.sh | grep "export REPOS" | tail -n 2 | head -n 1 | cut -f 2 -d '"'`
		do
    			# get the revision of the master repo
			MASTER_REV=`$SVN --username sysmgr --password p3+$+0r3 info $MASTER_SVN/neopets/$REPO | grep -i ^revision | cut -f2 -d ' '`
			# get the revision of the slave repo
			SLAVE_REV=`$SVN --username sysmgr --password p3+$+0r3 info $SLAVE_SVN/neopets/$REPO | grep -i ^revision | cut -f2 -d ' ' | sed -e 's/[^0-9]//'`
			# check if the revisions are not equal
			if [ -n $SLAVE_REV ] && [ `expr $SLAVE_REV + $SLACK` -le "$MASTER_REV" ]
			then
				echo "CRITICAL $REPO $SLAVE_ERROR out of sync with $MASTER_SVN (rev: $MASTER_REV)"
				exit 2
			fi
		done
		# REPO list from sync pull script -- swag special repos edition
		for REPO in `cat /usr/local/bin/sync_pull_script.sh | grep "export REPOS" | tail -n 1 | cut -f 2 -d '"'`
		do
    			# get the revision of the master repo
			MASTER_REV=`$SVN --username sysmgr --password p3+$+0r3 info $MASTER_SVN/swag/$REPO | grep -i ^revision | cut -f2 -d ' '`
			# get the revision of the slave repo
			SLAVE_REV=`$SVN --username sysmgr --password p3+$+0r3 info $SLAVE_SVN/swag/$REPO | grep -i ^revision | cut -f2 -d ' ' | sed -e 's/[^0-9]//'`
			# check if the revisions are not equal
			if [ -n $SLAVE_REV ] && [ `expr $SLAVE_REV + $SLACK` -le "$MASTER_REV" ]
			then
				echo "CRITICAL $REPO $SLAVE_ERROR out of sync with $MASTER_SVN (rev: $MASTER_REV)"
				exit 2
			fi
		done
	else
		echo "UKNONWN missing sync pull script /usr/local/bin/sync_pull_script.sh.  Is this supposed to run here?"
		exit 3
	fi
else
    echo "UNKNOWN Wrong usage. Use: $0 \$MASTER_SVN \$SLAVE_SVN"
    exit 3
fi

echo "OK SVN servers $* are in sync (`cat /usr/local/bin/sync_pull_script.sh | grep "export REPOS" | head -n 1 | cut -f 2 -d '"'` `cat /usr/local/bin/sync_pull_script.sh | grep "export REPOS" | tail -n 1 | cut -f 2 -d '"'`)"
exit 0
