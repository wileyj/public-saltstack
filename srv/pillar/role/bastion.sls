# role.ops.bastion
roles:
packages:
  bastion:
    - bind-libs
    - openssl
    - krb5-libs
    - glibc
    - zlib
    - keyutils
    - libselinux
    - libsepol
    - ncurses
    - fipscheck
    - nspr
    - iputils
    - zsh
    - perl-Convert-ASN1
    - perl-XML-Parser
    - perl-XML-Simple
    - perl-URI
    - perl-Authen-SASL
    - perl-Net-SSLeay
    - perl-GSSAPI
    - perl-Text-Template
    - zsh
modules:
  bastion:
    python:
    ruby:
    perl:
    golang:
ssh:
  config:
    max_auth_tries: 10
    tcp_keepalive: 'no'
    maxsessions: 5
    login_gracetime: 15
    print_motd: 'no'
    jailed_keyfile: /etc/ssh/authorized_keys/%u
services:
  apcid:
    state: disabled
    enabled: False
  anacron:
    state: disabled
    enabled: False
  atd:
    state: disabled
    enabled: False
  conman:
    state: disabled
    enabled: False
  cups:
    state: disabled
    enabled: False
  dhcdbd:
    state: disabled
    enabled: False
  dund:
    state: disabled
    enabled: False
  firstboot:
    state: disabled
    enabled: False
  gpm:
    state: disabled
    enabled: False
  haldaemon:
    state: disabled
    enabled: False
  hidd:
    state: disabled
    enabled: False
  ip6tables:
    state: disabled
    enabled: False
  irda:
    state: disabled
    enabled: False
  kudzu:
    state: disabled
    enabled: False
  mcstrans:
    state: disabled
    enabled: False
  mdmonitor:
    state: disabled
    enabled: False
  mdmpd:
    state: disabled
    enabled: False
  multipathd:
    state: disabled
    enabled: False
  netconsole:
    state: disabled
    enabled: False
  netfs:
    state: disabled
    enabled: False
  netplugd:
    state: disabled
    enabled: False
  nfs:
    state: disabled
    enabled: False
  nfslock:
    state: disabled
    enabled: False
  nscd:
    state: disabled
    enabled: False
  oddjobd:
    state: disabled
    enabled: False
  pand:
    state: disabled
    enabled: False
  pcscd:
    state: disabled
    enabled: False
  portmap:
    state: disabled
    enabled: False
  postfix:
    state: disabled
    enabled: False
  psacct:
    state: disabled
    enabled: False
  rdisc:
    state: disabled
    enabled: False
  readahead_early:
    state: disabled
    enabled: False
  readahead_later:
    state: disabled
    enabled: False
  restorecond:
    state: disabled
    enabled: False
  rpcgssd:
    state: disabled
    enabled: False
  rpcidmapd:
    state: disabled
    enabled: False
  rpcsvcgssd:
    state: disabled
    enabled: False
  saslauthd:
    state: disabled
    enabled: False
  sendmail:
    state: disabled
    enabled: False
  smartd:
    state: disabled
    enabled: False
  wpa_supplica:
    state: disabled
    enabled: False
  ypbind:
    state: disabled
    enabled: False
  yum-updatesd:
    state: disabled
    enabled: False
