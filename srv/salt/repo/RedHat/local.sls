# repo:redhat:local
{% set os_family = grains['os_family'] | default(None) %}
{% set os = grains['os'] | default(None) %}

repo {{ os_family }} - local_noarch:
    pkgrepo.managed:
        - name:  local_noarch
        - humanname : local noarch
        - baseurl : http://s3.amazonaws.com/local-package-repo/yum/RPMS/noarch
        - failovermethod : priority
        - enabled: 1
        - gpgcheck : 0
        - priority : 1

repo {{ os_family }} - local_x86_64:
    pkgrepo.managed:
        - name: local_x86_64
        - humanname : local x86-64
        - baseurl : http://s3.amazonaws.com/local-package-repo/yum/RPMS/x86_64
        - failovermethod : priority
        - enabled: 1
        - gpgcheck : 0
        - priority : 1
