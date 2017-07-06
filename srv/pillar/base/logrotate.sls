# base.logrotate
logrotate:
  jobs:
    syslog:
      path:
        - /var/log/cron
        - /var/log/maillog
        - /var/log/messages
        - /var/log/secure
        - /var/log/spooler
      config:
        - sharedscripts
        - postrotate
        -   /bin/kill -HUP `cat /var/run/syslogd.pid 2> /dev/null` 2> /dev/null || true
        - endscript
