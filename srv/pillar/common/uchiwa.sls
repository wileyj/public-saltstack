
uchiwa:
  classes: profiles::nodejs
  script_dir: "/usr/lib/golang/src/github.com/sensu/uchiwa"
  services:
    - uchiwa
  packages:
    - golang
    - golang-src

  golang:
    modules:
      - github.com/sensu/uchiwa
      - github.com/palourde/logger
      - github.com/dgrijalva/jwt-go
      - github.com/gorilla/context
      - github.com/mitchellh/mapstructure
      - github.com/stretchr/testify/assert
      - github.com/tools/godep

  users:
    uchiwa:
        ensure: present
        home:   /opt/uchiwa
        shell: /sbin/nologin
        uid:    491
        gid:    489

  files:
    /etc/init.d/uchiwa:
        source  : puppet:///modules/base/etc/init.d/uchiwa
        owner   : 'root'
        group   : 'root'
        mode    : '0755'
        replace : true

    /etc/logrotate.d/uchiwa:
        source  : puppet:///modules/base/etc/logrotate.d/uchiwa
        owner   : 'root'
        group   : 'root'
        mode    : '0644'
        replace : true

  sudo:
    uchiwa:
        sudo_config_dir:  /etc/sudoers.d
        content  : "# sudoers::uchiwa - This file is maintained by puppet\n#line 2"

  cron:
    uchiwa.cron:
        minute : '00'
        hour   : '06'
        user   : 'root'
        command: '#/usr/bin/sleeper 30 && /opt/scripts/apache_scripts/roll-logs.sh > /var/tmp/apache-restart.out 2>&1'

