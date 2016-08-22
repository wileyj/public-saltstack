networkcmds:
    priority : 1
    sudo_config_dir:  /etc/sudoers.d/
    content  : "# File Maintained by puppet. Do Not Edit Manually\nCmnd_Alias NETWORKCMDS = /bin/netstat, /usr/sbin/ifconfig, /usr/sbin/arp, /usr/sbin/tcpdump, /usr/sbin/iptables --list, /bin/traceroute"

devcmds:
    priority : 1
    sudo_config_dir:  /etc/sudoers.d/
    content  : "# File Maintained by puppet. Do Not Edit Manually\nCmnd_Alias DEVCMDS = /etc/init.d/passenger, /etc/init.d/mysql, /etc/init.d/apache, !/usr/bin/sudo,!/bin/su,!/bin/vi /etc/sudoers,!/usr/sbin/visudo,!/bin/bash,!/bin/csh,!/bin/ksh,!/bin/sh,!/bin/tcsh,!/bin/zsh"
