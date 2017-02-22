os_cleanup:
    packages:
        - autotools-dev
        - geomview
        - x11proto
        - xfonts*
        - gsfonts
        - gsfonts-x11
        - git
        - cpp-*
        - dpkg-dev
        - dictionaries-common
        - manpages
        - manpages-dev
        - whiptail
        - ubuntu-minimal
        - xkb-data
        - mlock
        - xpdf
        - qt3-dev-tools
        - libssl-dev
        - postfix
        - libxml2-dev
        - libexpat1-dev
    modules:
        python:
            - Mako
            - wsgiref
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
