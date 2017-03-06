# repo.debian.newrelic
{% set os_family = grains['os_family'] | default(None) %}
{% set os = grains['os'] | default(None) %}
{% set oscodename = grains['oscodename'] | default(None) %}
{% set role = pillar['role'] | default(None) %}

{% if role %}
{% set newrelic = pillar['role']['newrelic'] | default(None) %}
    {% if newrelic %}
        {% set newrelic_enabled = pillar['role']['newrelic']['enabled'] | default(None) %}
        {% set newrelic_packages = pillar['role']['newrelic']['packages'] | default(None) %}
    {% endif %}
{% endif %}

{% if role and newrelic and newrelic_packages and newrelic_enabled == true %}
repo {{ os_family }} - newrelic_repo:
    pkgrepo.managed:
        - humanname: newrelic non-free
        - name: deb http://apt.newrelic.com/debian/ newrelic non-free
        - file: /etc/apt/sources.list.d/newrelic.list
        - gpgcheck: 1
        - key_url: https://download.newrelic.com/548C16BF.gpg
        - clean_file: true
        - disabled: false
{% endif %}
