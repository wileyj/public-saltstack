# https://github.com/saltstack-formulas/logrotate-formula/blob/master/pillar.example
logrotate:
    yum:
      path:
        - /var/log/yum.log
      config:
        - missingok
        - notifempty
        - size 30k
        - yearly
        - create 0600 root root
