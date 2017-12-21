# role.ops.uchiwa
roles:
  - nginx
users:
  uchiwa:
      fullname: Uchiwa
      ensure: present
      home:   /opt/uchiwa
      shell: /sbin/nologin
      uid:    491
      gid:    489
      groups:
        - sensu

packages:
  golang:
    - golang
    - golang-src

services:
  uchiwa:
    running: True
    enabled: True

modules:
  golang:
    uchiwa:
      - github.com/sensu/uchiwa
      - github.com/palourde/logger
      - github.com/dgrijalva/jwt-go
      - github.com/gorilla/context
      - github.com/mitchellh/mapstructure
      - github.com/stretchr/testify/assert
      - github.com/tools/godeps

uchiwa:
  use_ssl: false
  path: ""
  timeout: 5000
  # port: 3000
  stats: 10
  refresh: 10000
  # admin_user: "admin"
  # admin_password: "adminpassword"
  users:
    wileyj:
      # password: "password"
      readonly: false

  datacenters:
    us-west-2:
      node: "shared-sensu-001.p.usw2.moil.io"

  classes: profiles::nodejs
  script_dir: "/usr/lib/golang/src/github.com/sensu/uchiwa"
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
