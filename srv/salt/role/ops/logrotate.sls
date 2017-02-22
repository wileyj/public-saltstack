# role:ops:logrotate
include:
    - logrotate
    - logrotate.jobs

logrotate runit dir - /etc/service/cron/run:
    file.directory:
        - name: /etc/service/cron
        - user: root
        - group: root
        - mode: 0755
        - makedirs: True

logrotate runit script - /etc/service/cron/run:
    file.managed:
        - name: /etc/service/cron/run
        - user: root
        - group: root
        - mode: 0755
        - source: salt://runit/files/etc/service/cron/run
