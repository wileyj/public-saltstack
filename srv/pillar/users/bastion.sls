# users.base
users:
  rzshuser:
    fullname: rzshuser account
    gid_from_name: False
    createhome: True
    unique: False
    uid: 1501
    gid: jailed
    shell: /sbin/nologin
    home: /home/rzshuser

  wileyj2:
    fullname: wileyj2 bastion account
    gid_from_name: False
    createhome: True
    unique: True
    uid: 1502
    gid: jailed
    shell: /bin/rzsh
    home: /export/jail/home/rzshuser
    groups:
      - jailed
    # pubkey: 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDjInfWqIveksB5JH4Mdsm2gNCVaNhwm4UF9dWFsbu4qIyEJzCWMivlIf2ivu7nCF5zyh3wZVo9hvvmVzjL/UBbI6kW8j9tGttSC0EoO0usvD0oTdaQoz9pWby4iyB1RAP7nCEmQcjHqertCiCjE6VfvW4jifewfxdWgVmJtdTJKJyStnTQCf8Y1EP1+KhQcj3M45tKWXX3SqeiIXhxdPM9nU2TrMrBeLbqN9fzvZKaY4aDJOTCMlxN9qipjfGhFFeJx8FtXPzsq6Eyt8Q3JV0sDi3r31Oqlm8udDsecvD0cbUnWMOjsja7Gvhw/zaL6VAnJT6UbAOnooUrWfrr02uz'

  wileyj3:
    fullname: wileyj3 bastion account
    gid_from_name: False
    createhome: True
    unique: True
    uid: 1503
    gid: jailed
    shell: /bin/rzsh
    home: /export/jail/home/rzshuser
    groups:
      - jailed
    # pubkey: 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDjInfWqIveksB5JH4Mdsm2gNCVaNhwm4UF9dWFsbu4qIyEJzCWMivlIf2ivu7nCF5zyh3wZVo9hvvmVzjL/UBbI6kW8j9tGttSC0EoO0usvD0oTdaQoz9pWby4iyB1RAP7nCEmQcjHqertCiCjE6VfvW4jifewfxdWgVmJtdTJKJyStnTQCf8Y1EP1+KhQcj3M45tKWXX3SqeiIXhxdPM9nU2TrMrBeLbqN9fzvZKaY4aDJOTCMlxN9qipjfGhFFeJx8FtXPzsq6Eyt8Q3JV0sDi3r31Oqlm8udDsecvD0cbUnWMOjsja7Gvhw/zaL6VAnJT6UbAOnooUrWfrr02uz'


groups:
  jailed:
    name: jailed
    gid: 1501
    system: False
