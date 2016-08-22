packages:
{% if grains.get('os') == 'Amazon' or grains.get('os') == 'RedHat' %}
  apache: httpd
  git: git
  jdk: jdk
  java: jdk
  python: python27
  python-pip: python27-pip
  python-setuptools: python27-setuptools
  python-tools: python27-tools
{% elif grains.get('os') == 'Debian' or grains.get('os') == 'Ubuntu' %}
  apache: apache2
  git: git-core
  java: openjdk
  jdk: openjdk
  python: python
  python-pip: python-pip
  python-setuptools: python-setuptools
  python-tools: python-tools
%{ else %}
  apache: httpd
  git: git
  java: jdk
  jdk: jdk
  python: python27
  python-pip: python27-pip
  python-setuptools: python27-setuptools
  python-tools: python27-tools
{% endif %}

  base:
    - strace
    - sysstat
    - coreutils
    - lsof
    - telnet
    - at
    - nc
    - bc
    - tcsh
    - traceroute
    - binutils
    - bzip2
    - rsync
    - ruby
    - bash
    - curl
    - bind-utils
    - gcc
    - openssh-clients
    - openssh-server
    - openssh

  harden:
    - duo
    - duo-libs
    - duo-pam
    - chkrootkit
    - rkhunter
    - nmap
    - tcpdump
    - denyhosts
    - iptables
    - psad
    - fail2ban
    - logwatch
    - aide
    - vlock

  remove:
    - xinetd
    - telnet-server
    - rsh-server
    - rsh
    - ypbind
    - ypserv
    - tftp-server
    - cronie-anacron
    - vsftpd
    - httpd
    - dovecot

  yum:
    - yum-plugin-priorities
    - deltarpm
    - rubygem-rgen
    - rubygem-json_pure
    - ruby-libs
    - rubygems
    - rubygem-bigdecimal
    - rubygem-psych
    - perl-Proc-ProcessTable
    - perl-libwww-perl

  apt:
    - ruby
