# repo:redhat:epel
{% set os_family = grains['os_family'] | default(None) %}
{% set os = grains['os'] | default(None) %}

repo {{ os_family }} - epel:
    pkgrepo.managed:
        - name: epel
        - humanname : epel
        - mirrorlist : https://mirrors.fedoraproject.org/metalink?repo=epel-6&arch=$basearch
        - gpgkey : file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-6
        - failovermethod : priority
        - disabled : 1
        - gpgcheck : 1
        - priority : 2

repo {{ os_family }} - epel-source:
    pkgrepo.managed:
        - name: epel-source
        - humanname : epel source
        - mirrorlist : https://mirrors.fedoraproject.org/metalink?repo=epel-source-6&arch=$basearch
        - gpgkey : file:///etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-6
        - failovermethod : priority
        - disabled : 1
        - gpgcheck : 1
        - priority : 2
