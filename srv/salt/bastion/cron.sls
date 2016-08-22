chroot.cron:
    minute : '00'
    hour   : '*/2'
    user   : 'root'
    command: '/bin/rm -rf /etc/sysconfig/chroot_setup 2>&1'
