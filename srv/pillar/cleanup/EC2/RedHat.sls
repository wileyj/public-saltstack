# cleanup.EC2.RedHat
os_cleanup:
    packages:
        - libx11-common
        - cpp*
        - man-db
        - newt
        - libxkb
        - lvm2-mlock
        - poppler
        - qt3-devel
        - yum-utils
        - gobject-introspection
        - libgnome-keyring
        - openssh-clients
        - rsync
        - groff-base
        - dovecot
    modules:
        python:
            - colorama
            - iniparse
            - kitchen
    dirs:
        empty:
            - /var/cache/yum
            - /var/lib/yum
    files:
        empty:
            - /var/log/yum.log
