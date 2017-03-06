# we're using the service cron since logrotate uses cron to run
logrotate runit dir:
    file.directory:
        - name: /etc/service/cron
        - user: root
        - group: root
        - mode: 0755
        - makedirs: True

logrotate runit script:
    file.managed:
        - name: /etc/service/cron/run
        - user: root
        - group: root
        - mode: 0755
        - source: salt://runit/files/etc/service/cron/run
