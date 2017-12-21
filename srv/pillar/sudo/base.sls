# sudo.base
sudoers:
  included_files:
    /etc/sudoers.d/networkcmds:
      aliases:
        NETWORKCMDS:
          - /bin/netstat
          - /usr/sbin/ifconfig
          - /usr/sbin/arp
          - /usr/sbin/tcpdump
          - '/usr/sbin/iptables --list'
          - /bin/traceroute
    /etc/sudoers.d/devcmds:
        DEVCMDS:
          - /etc/init.d/passenger
          - /etc/init.d/mysql
          - /etc/init.d/apache
          - '!/usr/bin/sudo'
          - '!/bin/su'
          - '!/bin/vi /etc/sudoers'
          - '!/usr/sbin/visudo'
          - '!/bin/bash'
          - '!/bin/csh'
          - '!/bin/ksh'
          - '!/bin/sh'
          - '!/bin/tcsh'
          - '!/bin/zsh'
    /etc/sudoers.d/devs:
      groups:
        devs:
          - 'ALL=(ALL) NOPASSWD:DEVCMDS, NETWORKCMDS'
    /etc/sudoers.d/admins:
      groups:
        admins:
          - 'ALL=(ALL) NOPASSWD:ALL'

#   /etc/sudoers.d/centos:
#     users:
#       centos:
#         - 'ALL=(ALL) ALL'
