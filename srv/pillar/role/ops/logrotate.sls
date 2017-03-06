# role.ops.logrotate
role:
    newrelic:
        enabled: false
        packages:
    dirs:
        delete:
        empty:
        symlink:
        create:

    files:
        delete:
        empty:
        symlink:
        create:
    custom:
        packages:
    packages:
        - logrotate
    modules:
        python:
        ruby:
        perl:
logrotate:
    lookup:
        pkg: logrotate
        service: crond
    jobs:
        /tmp/var/log/mysql/error:
            path:
                - /tmp/var/log/mysql/error
            config:
                - weekly
                - missingok
                - rotate 52
                - compress
                - delaycompress
                - notifempty
                - create 640 root
                - sharedscripts

        /srv/log/file:
            path:
                - /tmp/var/log/mysql/error
            config:
                - weekly
                - missingok
                - rotate 52
                - compress
                - delaycompress
                - notifempty
                - create 640 root
                - sharedscripts

        ecs:
            path:
                - /var/log/ecs/ecs-agent.log.*
            config:
                - daily
                - missingok
                - nomail
                - rotate 10
                - nocompress
                - notifempty
                - create 640 root
                - sharedscripts
