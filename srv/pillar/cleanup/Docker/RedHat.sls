# cleanup.Docker.RedHat
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
        ruby:
        perl:
    dirs:
        delete:
        empty:
            - /var/cache/yum
            - /var/lib/yum
        symlink:
        create:
    files:
        delete:
        empty:
            - /var/log/yum.log
        symlink:
        create:
