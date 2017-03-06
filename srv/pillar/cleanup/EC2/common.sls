# cleanup.EC2.common
common_cleanup:
    packages:
        - automake
        - autoconf
        - ghostscript
        - make
        - xinetd
        - telnet-server
        - rsh-server
        - rsh
        - ypbind
        - ypserv
        - tftp-server
        - cronie-anacron
        - vsftpd

    modules:
        python:
            - docutils
        ruby:
        perl:
    dirs:
        delete:
        empty:
            - /var/log/fsck
            - /root/.cache
            - /usr/share/doc
            - /usr/share/man
        symlink:
        create:
    files:
        delete:
        empty:
        symlink:
        create:
