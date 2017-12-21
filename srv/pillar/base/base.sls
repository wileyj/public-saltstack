# base.base
# company: moil
# domain:  moil.io
env:
  base:
    gopath:
      - /usr/lib/golang
    path:
      - /sbin
      - /bin
      - /usr/sbin
      - /usr/bin
      - $HOME/bin
      - /usr/local/bin
      - /usr/local/sbin
ssh:
  config:
    # port: 22
    protocol: 2
    login_grace_time: 30
    strict_modes: 'yes'
    max_auth_tries: 20
    root_allowed: 'no'
    gateway_ports: 'yes'
    tcp_keepalive: 'yes'
    usepam: 'yes'
    client_alive_interval: 0
    client_alive_max: 0
    permit_tunnel: 'yes'
    passwordauthentication: 'no'
    challengeresponseauthentication: 'no'
    maxstartups: 20:30:60
    log_level: INFO
    syslogfacility: AUTH
    x11_forwarding: 'no'
    allow_tcp_forwarding: 'yes'
    use_privilege_separation: 'yes'
    allow_agent_forwarding: 'yes'
    maxsessions: 10
    login_gracetime: 30
    use_dns: 'no'
    keyfile: .ssh/authorized_keys
    print_motd: 'no'
    print_lastlog: 'yes'
    banner: /etc/motd
    permit_empty_passwords: 'no'
    pubkey_auth: 'yes'
    dsa_auth: 'yes'
    ignore_rhosts: 'yes'
    pidfile: '/var/run/sshd.pid'
