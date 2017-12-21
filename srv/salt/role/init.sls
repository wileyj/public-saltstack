# role.init
{% set role = pillar['role'] | default(None) %}
{% set instance = grains['instance'] | default(None) %}
{% if role and instance %}
    {% set newrelic = pillar['role']['newrelic'] | default(None) %}
    {% set instance_application = grains['application'] | default(None) %}
    {% set instance_role = grains['role'] | default(None) %}
    {% if newrelic %}
        {% set newrelic_enabled = pillar['role']['newrelic']['enabled'] | default(None) %}
        {% set newrelic_packages = pillar['role']['newrelic']['packages'] | default(None) %}
    {% endif %}
    include:
    {% if instance_application and instance_role  %}
        - role/{{ instance_application }}.{{ instance_role }}
    {% endif %}
    {% if newrelic and newrelic_packages and newrelic_enabled == true %}
        - source_install.newrelic
    {% endif %}
{% endif %}
