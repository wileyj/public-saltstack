# virtual_type.EC2.common.denyhosts
denyhosts:
  services:
    denyhosts:
      state: running
      enabled: True
  packages:
    denyhosts:
      - denyhosts
  config:
    hosts_deny: /etc/hosts.deny
    block_service: all
    work_dir: /opt/denyhosts/data
    suspicious_login_report: NO
    {% if grains.get('os_family') != "Debian" %}
    lock_file: /var/lock/subsys/denyhosts
    secure_log: "/var/log/messages"
    {% else %}
    lock_file: /var/lock/subsys/denyhosts
    secure_log: "/var/log/syslog"
    {% endif %}
    hostname_lookup: YES
    syslog_report: false
    age_reset_valid: 2d
    age_reset_root: 5y
    age_reset_invalid: 10d
    reset_on_success: true
    reset_valid: 2d
    deny_threshold:
      invalid: 5
      valid: 5
      root: 1
      restricted: 1
    daemon:
      sleep: 30s
      purge: 1h
      log: /var/log/denyhosts
      log_time_format: '%b %d %I:%M:%S'
      log_message_format: '%(asctime)s -  %(name)-12s: %(levelname)-8s %(message)s'
    sync:
      server: http://xmlrpc.denyhosts.net:9911
      interval: 1h
      upload: no
      download: yes
      download_threshold: 10
      download_resiliency:  2d
    purge:
      deny: 5y
      threshold: 0
