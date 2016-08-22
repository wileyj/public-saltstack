/opt/scripts/chroot_setup.pl:
    owner   : 'root'
    group   : 'root'
    ensure  : present
    replace : true
    mode    : '0755'
    source  : puppet:///modules/bastion/opt/scripts/chroot_setup.pl

/export:
    ensure : directory

/export/jail:
    ensure : directory

/export/jail/etc:
    ensure : directory
