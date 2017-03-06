# sumologic.packages
{% set sumo_dl_url = pillar['role']['sumo_dl_url'] | default(None) %}
{% set os_family = grains['os_family'] | default(None) %}
{% if sumo_dl_url %}
    {% if os_family == 'RedHat' %}
        sumologic install https://collectors.sumologic.com/rest/download/rpm/64:
            cmd.run:
                - cwd: /
                - name: rpm -Uvh {{ sumo_dl_url }}
                - unless: test -e /opt/SumoCollector/wrapper
    {% endif %}
{% endif %}
