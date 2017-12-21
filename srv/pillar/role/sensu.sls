# role.ops.sensu
roles:
sensu:
  services:
    server:
      sensu-server:
        state: running
        enabled: True
      sensu-api:
        state: running
        enabled: True
  packages:
    server:
      - sensu-api
      - sensu-server
  mail:
    from: "root@sensu.moil.io"
    to: "alerts@moil.io"
    dev: "alerts@moil.io"
    alerts: "alerts@moil.io"
logrotate:
  jobs:
    sensu-server:
      path:
        - /var/log/sensu/sensu-server.log
      config:
        - sharedscripts
        - compress
        - rotate 7
        - missingok
        - notifempty
        - daily
        - copytruncate
        - postrotate
        - kill -USR2 `cat /var/run/sensu/sensu-server.pid 2> /dev/null` 2> /dev/null || true
        - endscript
    sensu-api:
      path:
        - /var/log/sensu/sensu-api.log
      config:
        - sharedscripts
        - compress
        - rotate 7
        - missingok
        - notifempty
        - daily
        - copytruncate
        - postrotate
        - kill -USR2 `cat /var/run/sensu/sensu-api.pid 2> /dev/null` 2> /dev/null || true
        - endscript
