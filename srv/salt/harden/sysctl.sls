# harden.sysctl
harden sysctl - kernel.exec-shield:
  sysctl.present:
    - name: kernel.exec-shield
    - value: 1

harden sysctl - kernel.randomize_va_space:
  sysctl.present:
    - name: kernel.randomize_va_space
    - value: 1

# Enable IP spoofing protection
harden sysctl - net.ipv4.conf.all.rp_filter:
  sysctl.present:
    - name: net.ipv4.conf.all.rp_filter
    - value: 1

# Disable IP source routing
harden sysctl - net.ipv4.conf.all.accept_source_route:
  sysctl.present:
    - name: net.ipv4.conf.all.accept_source_route
    - value: 0

# Ignoring broadcasts request
harden sysctl - net.ipv4.icmp_echo_ignore_broadcasts:
  sysctl.present:
    - name: net.ipv4.icmp_echo_ignore_broadcasts
    - value: 1
harden sysctl - net.ipv4.icmp_ignore_bogus_error_messages:
  sysctl.present:
    - name: net.ipv4.icmp_ignore_bogus_error_messages
    - value: 1

# Make sure spoofed packets get logged
harden sysctl - net.ipv4.conf.all.log_martians:
  sysctl.present:
    - name: net.ipv4.conf.all.log_martian
    - value: 1
