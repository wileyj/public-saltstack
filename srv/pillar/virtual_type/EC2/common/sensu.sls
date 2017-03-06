# virtual_type.EC2.common.sensu
sensu:
  host: shared-sensu-001.p.use1.domain.com
  purge_config: true
  log_level : info
  services:
    api:
      host: shared-sensu-001.p.use1.domain.com
      port: 4567
      user: user
      password: password
    rabbitmq:
      host: shared-sensu-001.p.use1.domain.com
      port: 5672
      ssl::port: 5671
      vhost: /sensu
      user: sensu
      password: secret
      ssl:
        private_key: undef
        cert_chain: undef
        #private_key: "/etc/sensu/ssl/client_key.pem"
        #cert_chain: "/etc/sensu/ssl/client_cert.pem"
    redis:
      host: shared-sensu-001.p.use1.domain.com
      port: 6379

    graphite:
      host: platform-graphite-001.p.use1.domain.com
      port: 2003

  client:
    warning: 90
    critical: 300
    refresh: 900
    custom: undef
    subscriptions:
      - default
      - linux
      - metrics
    services:
      - sensu-client
    packages:
      - sensu-client
      - rubygem-multi_json
      - rubygem-sensu-plugins-ansible
      - rubygem-sensu-plugins-apache
      - rubygem-sensu-plugins-aws
      - rubygem-sensu-plugins-beanstalk
      - rubygem-sensu-plugins-conntrack
      - rubygem-sensu-plugins-cpu-checks
      - rubygem-sensu-plugins-disk-checks
      - rubygem-sensu-plugins-dns
      - rubygem-sensu-plugins-filesystem-checks
      - rubygem-sensu-plugins-golang
      - rubygem-sensu-plugins-graphite
      - rubygem-sensu-plugins-haproxy
      - rubygem-sensu-plugins-http
      - rubygem-sensu-plugins-java
      - rubygem-sensu-plugins-jenkins
      - rubygem-sensu-plugins-load-checks
      - rubygem-sensu-plugins-memory-checks
      - rubygem-sensu-plugins-network-checks
      - rubygem-sensu-plugins-nginx
      - rubygem-sensu-plugins-ntp
      - rubygem-sensu-plugins-postgres
      - rubygem-sensu-plugins-process-checks
      - rubygem-sensu-plugins-rabbitmq
      - rubygem-sensu-plugins-redis
      - rubygem-sensu-plugins-slack
      - rubygem-sensu-plugins-ssl
      - rubygem-sensu-plugins-uchiwa
      - rubygem-sensu-plugins-uptime-checks
      - rubygem-sensu-plugins-vmstats

  server:
    mail_from: root@sensu.domain.com
    mail_to: alerts@domain.com
    mail_dev: alerts@domain.com
    mail_alerts: alerts@domain.com
    packages:
      - sensu-api
      - sensu-server
    services:
      - sensu-server
      - sensu-api
