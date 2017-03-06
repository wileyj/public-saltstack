# virtual_type.EC2.RedHat.logrotate
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
