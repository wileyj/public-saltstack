# users.base
users:
  wileyj:
    fullname: wileyj
    uid: 501
    gid: 1410
    shell: /bin/bash
    home: /home/wileyj
    gid_from_name: False
    groups:
      - admins
    # pubkey: 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDjInfWqIveksB5JH4Mdsm2gNCVaNhwm4UF9dWFsbu4qIyEJzCWMivlIf2ivu7nCF5zyh3wZVo9hvvmVzjL/UBbI6kW8j9tGttSC0EoO0usvD0oTdaQoz9pWby4iyB1RAP7nCEmQcjHqertCiCjE6VfvW4jifewfxdWgVmJtdTJKJyStnTQCf8Y1EP1+KhQcj3M45tKWXX3SqeiIXhxdPM9nU2TrMrBeLbqN9fzvZKaY4aDJOTCMlxN9qipjfGhFFeJx8FtXPzsq6Eyt8Q3JV0sDi3r31Oqlm8udDsecvD0cbUnWMOjsja7Gvhw/zaL6VAnJT6UbAOnooUrWfrr02uz'

  wileyj2:
    fullname: wileyj2
    uid: 502
    gid: 1410
    gid_from_name: False
    shell: /bin/bash
    home: /home/wileyj2

groups:
  dev:
    name: dev
    gid: 1110
    system: False

  analytics:
    name: analytics
    gid: 1210
    system: False

  admins:
    name: admins
    gid: 1010
    system: False

  db:
    name: db
    gid: 1310
    system: False

  users:
    name: users
    gid: 1410
