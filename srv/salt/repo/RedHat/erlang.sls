# repo.redhat.erlang
{% set os_family = grains['os_family'] | default(None) %}
{% set os = grains['os'] | default(None) %}

repo {{ os_family }} - erlang-solutions:
    pkgrepo.managed:
        - name: erlang-solutions
        - humanname: Centos $releasever - $basearch - Erlang Solutions
        - mirrorlist : http://packages.erlang-solutions.com/rpm/centos/$releasever/$basearch
        - gpgkey: http://packages.erlang-solutions.com/debian/erlang_solutions.asc
        - gpgcheck: 0
        - disabled: 1
        - priority: 1
