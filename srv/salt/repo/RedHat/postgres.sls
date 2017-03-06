# repo.redhat.postgres
{% set os_family = grains['os_family'] | default(None) %}
{% set os = grains['os'] | default(None) %}

repo {{ os_family }} - pgdg95:
    pkgrepo.managed:
        - name: pgdg95
        - humanname : PostgreSQL 9.5 - $basearch
        - mirrorlist : https://download.postgresql.org/pub/repos/yum/9.5/redhat/rhel-6-$basearch
        - gpgkey : https://download.postgresql.org/pub/repos/yum/RPM-GPG-KEY-PGDG-95
        - disabled : 1
        - gpgcheck : 1
        - priority : 2

repo {{ os_family }} - pgdg95-source:
    pkgrepo.managed:
        - name: pgdg95-source
        - humanname : PostgreSQL 9.5 Source $basearch
        - mirrorlist : https://download.postgresql.org/pub/repos/yum/srpms/9.5/redhat/rhel-6-$basearch
        - gpgkey : https://download.postgresql.org/pub/repos/yum/RPM-GPG-KEY-PGDG-95
        - failovermethod : priority
        - disabled : 1
        - gpgcheck : 1
        - priority : 2
