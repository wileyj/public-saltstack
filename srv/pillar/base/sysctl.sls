# base.sysctl
{% if grains['os'] == "Debian" or grains['os'] == "Ubuntu" or grains['os'] == "Amazon" %}
{% set procps = "procps" %}
{% else %}
{% set procps = "procps-ng" %}
{% endif %}

sysctl:
  lookup:
    pkg: {{ procps }}
    config:
      location: '/etc/sysctl.d'
  params:
    fs.file-max: 209708
    fs.suid_dumpable: 0
    kernel.core_uses_pid: 1
    kernel.panic_on_oops: 1
    kernel.panic: 31
    kernel.printk: 3 4 1 3
    kernel.randomize_va_space: 2
    kernel.sysrq: 0
    net.core.dev_weight: 64
    net.core.netdev_max_backlog: 65536
    net.core.optmem_max: 25165824
    net.core.rmem_default: 31457280
    net.core.rmem_max: 12582912
    net.core.somaxconn: 4096
    net.core.wmem_default: 31457280
    net.core.wmem_max: 12582912
    net.ipv4.conf.all.accept_redirects: 0
    net.ipv4.conf.all.accept_source_route: 0
    net.ipv4.conf.all.log_martians: 1
    net.ipv4.conf.all.rp_filter: 1
    net.ipv4.conf.all.secure_redirects: 0
    net.ipv4.conf.all.send_redirects: 0
    net.ipv4.conf.default.accept_redirects: 0
    net.ipv4.conf.default.accept_source_route: 0
    net.ipv4.conf.default.rp_filter: 1
    net.ipv4.conf.default.secure_redirects: 0
    net.ipv4.conf.default.send_redirects: 0
    net.ipv4.icmp_echo_ignore_all: 1
    net.ipv4.icmp_echo_ignore_broadcasts: 1
    net.ipv4.icmp_ignore_bogus_error_responses: 1
    net.ipv4.ip_default_ttl: 61
    net.ipv4.ip_forward: 0
    net.ipv4.ip_local_port_range: 2000 65535
    net.ipv4.tcp_fin_timeout: 15
    net.ipv4.tcp_keepalive_intvl: 15
    net.ipv4.tcp_keepalive_probes: 5
    net.ipv4.tcp_keepalive_time: 300
    net.ipv4.tcp_max_syn_backlog: 4096
    net.ipv4.tcp_max_tw_buckets: 1440000
    net.ipv4.tcp_mem: 65536 131072 262144
    net.ipv4.tcp_rfc1337: 1
    net.ipv4.tcp_rmem: 8192 87380 16777216
    net.ipv4.tcp_sack: 0
    net.ipv4.tcp_syn_retries: 5
    net.ipv4.tcp_synack_retries: 2
    net.ipv4.tcp_syncookies: 1
    net.ipv4.tcp_tw_recycle: 1
    net.ipv4.tcp_tw_reuse: 1
    net.ipv4.tcp_wmem: 8192 65536 16777216
    net.ipv4.udp_mem: 65536 131072 262144
    net.ipv4.udp_rmem_min: 16384
    net.ipv4.udp_wmem_min: 16384
    net.ipv6.conf.all.accept_redirects: 0
    net.ipv6.conf.all.accept_source_route: 0
    net.ipv6.conf.all.disable_ipv6: 1
    net.ipv6.conf.all.forwarding: 0
    net.ipv6.conf.default.accept_redirects: 0
    net.ipv6.conf.default.accept_source_route: 0
    net.ipv6.conf.default.disable_ipv6: 1
    net.ipv6.conf.lo.disable_ipv6: 1
    vm.dirty_background_ratio: 2
    vm.dirty_ratio: 60
    vm.overcommit_memory: 0
    vm.overcommit_ratio: 90
    vm.swappiness: 10
