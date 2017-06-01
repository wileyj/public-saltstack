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

        prod-apache:
            path:
                - /var/log/apache2/*.log
            config:
                - daily
                - missingok
                - nomail
                - rotate 10
                - nocompress
                - size 100M
                - notifempty
                - create 640 root
                - sharedscripts
                - postrotate
                - /usr/sbin/apachectl graceful > /dev/null 2>/dev/null
                - endscript
