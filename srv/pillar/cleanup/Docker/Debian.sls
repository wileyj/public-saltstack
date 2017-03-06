# cleanup.Docker.Debian
os_cleanup:
    packages:
        - openssh-client
        - python-async
        - python-git
        - python-gitdb
        - python-mysqldb
        - python-smmap
        - rsync
        - git
        - git-man
        - liberror-perl
        - libx11-dev*
        - x11proto-core-dev*
        - libasound2-dev*
        - libxcb1-dev*
        - libxcb-rand*
        - libxcb-xfixes0*
        - libx11-doc
        - xorg-sgml-doctools
        - linux-libc-dev

    modules:
        python:
        ruby:
        perl:
    dirs:
        delete:
        empty:
            - /var/lib/apt/lists
            - /var/log/apt
            - /var/cache/apt
        symlink:
        create:
    files:
        delete:
        empty:
            - /var/log/dpkg.log
            - /var/log/alternatives.log
        symlink:
        create:
