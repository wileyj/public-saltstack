{% if pillar['role'] is defined and pillar['role']['newrelic'] is defined %}
    {% set newrelic_packages = pillar['role']['newrelic']['packages'] | default(None) %}

    {% if newrelic_packages %}
        source_install newrelic packages:
            pkg.installed:
                - refresh: true
                - pkgs: {{ newrelic_packages }}
    {% endif %}
{% endif %}
