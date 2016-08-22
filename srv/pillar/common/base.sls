company: Fake Company
domain: domain.com
yum:
  server: 1.1.1.1
ssh:
  config:
    root_allowed: no
    password_allowed: no

path:
  gopath: /usr/lib/golang/
  path:
    - /bin:/usr/bin
    - /usr/local/bin
    - /sbin
    - /usr/sbin
    - /usr/local/sbin
    - $HOME/bin
