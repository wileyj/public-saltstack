base:
    dirs:
        delete:
        empty:
        symlink:
            /u/log:
                source: /u/logs
                dest: /u/log
        create:
            - /u
            - /u/log
            - /opt
            - /opt/scripts
            - /etc/service
    files:
        delete:
        empty:
        symlink:
        create:
