  fs.file-max :
    sysctl.present:
      - value: 209708

  kernel.core_uses_pid :
    sysctl.present:
      - value: 1

  kernel.panic :
    sysctl.present:
      - value: 30

  kernel.panic_on_oops :
    sysctl.present:
      - value: 1

  kernel.sysrq :
    sysctl.present:
      - value: 0

  net.core.dev_weight :
    sysctl.present:
      - value: 64

  net.core.netdev_max_backlog :
    sysctl.present:
      - value: 4096

  net.core.optmem_max :
    sysctl.present:
      - value: 20480

  net.core.rmem_default :
    sysctl.present:
      - value: 1048560

  net.core.rmem_max :
    sysctl.present:
      - value: 1048560

  net.core.somaxconn :
    sysctl.present:
      - value: 32768

  net.core.wmem_default :
    sysctl.present:
      - value: 1048560

  net.core.wmem_max :
    sysctl.present:
      - value: 1048560

  net.ipv4.conf.all.accept_source_route :
    sysctl.present:
      - value: 0

  net.ipv4.conf.all.log_martians :
    sysctl.present:
      - value: 1

  net.ipv4.icmp_echo_ignore_broadcasts :
    sysctl.present:
      - value: 1

  net.ipv4.icmp_ignore_bogus_error_responses :
    sysctl.present:
      - value: 1

  net.ipv4.ip_default_ttl :
    sysctl.present:
      - value: 61

  net.ipv4.tcp_fin_timeout :
    sysctl.present:
      - value: 15

  net.ipv4.tcp_keepalive_time :
    sysctl.present:
      - value: 600

  net.ipv4.tcp_max_syn_backlog :
    sysctl.present:
      - value: 2048

  net.ipv4.tcp_max_tw_buckets :
    sysctl.present:
      - value: 1440000

  net.ipv4.tcp_rfc1337 :
    sysctl.present:
      - value: 1

  net.ipv4.tcp_sack :
    sysctl.present:
      - value: 0

  net.ipv4.tcp_syncookies :
    sysctl.present:
      - value: 1
