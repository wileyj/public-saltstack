erlang-solutions:
  pkgrepo.managed:
    - humanname: Centos $releasever - $basearch - Erlang Solutions
    - mirrorlist : http://packages.erlang-solutions.com/rpm/centos/$releasever/$basearch
    - gpgkey: http://packages.erlang-solutions.com/debian/erlang_solutions.asc
    - gpgcheck: 0
    - enabled: 0
    - priority: 1

erlang-solutions:
  pkgrepo.managed:
    - humanname : Centos $releasever - $basearch - Erlang Solutions
    - mirrorlist : http://packages.erlang-solutions.com/rpm/centos/$releasever/$basearch
    - gpgkey : http://packages.erlang-solutions.com/debian/erlang_solutions.asc
    - gpgcheck : 0
    - enabled : 0
    - priority : 1

pgdg95:
  pkgrepo.managed:
    - humanname : PostgreSQL 9.5 - Amazon Linux AMI 2015.03 - $basearch
    - mirrorlist : https://download.postgresql.org/pub/repos/yum/9.5/redhat/rhel-6-$basearch
    - gpgkey : https://download.postgresql.org/pub/repos/yum/RPM-GPG-KEY-PGDG-95
    - enabled : 1
    - gpgcheck : 1
    - priority : 2

pgdg95-source:
  pkgrepo.managed:
    - humanname : PostgreSQL 9.5 Amazon Linux AMI 2015.03 - $basearch - Source
    - mirrorlist : https://download.postgresql.org/pub/repos/yum/srpms/9.5/redhat/rhel-6-$basearch
    - gpgkey : https://download.postgresql.org/pub/repos/yum/RPM-GPG-KEY-PGDG-95
    - failovermethod : priority
    - enabled : 0
    - gpgcheck : 1
    - priority : 2

epel:
  pkgrepo.managed:
    - humanname : epel
    - mirrorlist : https://mirrors.fedoraproject.org/metalink?repo=epel-6&arch=$basearch
    - gpgkey : file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-6
    - failovermethod : priority
    - enabled : 0
    - gpgcheck : 1
    - priority : 2

epel-source:
  pkgrepo.managed:
    - humanname : epel-source
    - mirrorlist : https://mirrors.fedoraproject.org/metalink?repo=epel-source-6&arch=$basearch
    - gpgkey : file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-6
    - failovermethod : priority
    - enabled : 0
    - gpgcheck : 1
    - priority : 2

local_noarch:
  pkgrepo.managed:
    - humanname : local_noarch
    - mirrorlist : http://54.84.207.213/RPMS/noarch
    - failovermethod : priority
    - gpgcheck : 0
    - priority : 1

local_x86_64:
  pkgrepo.managed:
    - humanname : local_x86-64
    - mirrorlist : http://54.84.207.213/RPMS/x86_64
    - failovermethod : priority
    - gpgcheck : 0
    - priority : 1
