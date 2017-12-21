# repo.redhat.moil
{% set os_family = grains['os_family'] | default(None) %}
{% set os = grains['os'] | default(None) %}

repo {{ os_family }} - rabbitmq-erlang:
    pkgrepo.managed:
        - name:  rabbitmq-erlang
        - humanname : rabbitmq-erlang
        - baseurl : https://dl.bintray.com/rabbitmq/rpm/erlang/20/el/7
        - enabled: 1
        - gpgcheck : 1
        - priority : 1
        - repo_gpgcheck: 0
        - gpgkey: https://www.rabbitmq.com/rabbitmq-release-signing-key.asc
