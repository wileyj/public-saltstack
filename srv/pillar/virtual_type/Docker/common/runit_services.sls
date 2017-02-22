# runit services
cron:
    file.managed:
        /etc/service/cron:
            - present: True
        /etc/service/cron/run:
            - present: True

    service:
        - running
        - provider: runit
