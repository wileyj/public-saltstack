# repo.redhat.moil
{% set os_family = grains['os_family'] | default(None) %}
{% set os = grains['os'] | default(None) %}

repo {{ os_family }} - moil_noarch:
    pkgrepo.managed:
        - name:  moil_noarch
        - humanname : moil noarch
        - baseurl : http://yumrepo.moil.io/noarch
        - failovermethod : priority
        - enabled: 1
        - gpgcheck : 0
        - priority : 1
        - repo_gpgcheck: 0
        - gpgkey: http://yumrepo.moil.io/RPM-GPG-KEY-wileyj

repo {{ os_family }} - moil_x86_64:
    pkgrepo.managed:
        - name: moil_x86_64
        - humanname : moil x86-64
        - baseurl : http://yumrepo.moil.io/x86_64
        - failovermethod : priority
        - enabled: 1
        - gpgcheck : 0
        - priority : 1
        - repo_gpgcheck: 0
        - gpgkey: http://yumrepo.moil.io/RPM-GPG-KEY-wileyj
