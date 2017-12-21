# base.sensu
sensu:
  services:
    client:
      sensu-client:
        state: running
        enabled: True
  packages:
    client:
      - sensu-client
      - rubygem-sensu-plugins-cpu-checks
      - rubygem-sensu-plugins-disk-checks
      - rubygem-sensu-plugins-dns
      - rubygem-sensu-plugins-filesystem-checks
      - rubygem-sensu-plugins-graphite
      - rubygem-sensu-plugins-java
      - rubygem-sensu-plugins-load-checks
      - rubygem-sensu-plugins-memory-checks
      - rubygem-sensu-plugins-network-checks
      - rubygem-sensu-plugins-process-checks
      - rubygem-sensu-plugins-ssl
      - rubygem-sensu-plugins-uptime
      - rubygem-sensu-plugins-vmstats
  mail:
    to: "to@localhost"
    from: "from@localhost"
    alerts: "alerts@localhost"
    dev: "dev@localhost"
  host: "shared-sensu-001.p.usw2.moil.io"
  config:
    client:
      purge: true
      log_level : info
      subscriptions:
        - default
        - linux
        - metrics
      warning: 90
      critical: 300
      refresh: 900
      custom: 'undef'
  rabbitmq:
      host: "shared-sensu-001.p.usw2.moil.io"
      # port: 5672
      vhost: "/sensu"
      # user: "sensu"
      # password: "secret"
  ssl:
      # port: 5671
      private_key: undef
      cert_chain: undef
  redis:
      # port: 6379
      host: "shared-sensu-001.p.usw2.moil.io"
  graphite:
      # port: 2003
      host: "platform-graphite-001.p.usw2.moil.io"
  api:
      host: "shared-sensu-001.p.usw2.moil.io"
      # port: 4567
      # user: "username"
      # password: "password"
logrotate:
  jobs:
    sensu-client:
      path:
        - /var/log/sensu/sensu-client.log
      config:
        - sharedscripts
        - compress
        - rotate 7
        - missingok
        - notifempty
        - daily
        - copytruncate
        - postrotate
        - kill -USR2 `cat /var/run/sensu/sensu-client.pid 2> /dev/null` 2> /dev/null || true
        - endscript
