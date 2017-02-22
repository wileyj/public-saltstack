# application: platform
{% set application = pillar['application'] | default(None) %}
{% if application  %}
    {% set application_users = pillar['application']['users'] | default(None) %}
    {% set application_groups = pillar['application']['groups'] | default(None) %}
{% endif %}
{% if application and application_users and application_groups %}
    {% set owner_user = pillar['application']['users'][grains['instance']['application']]['name'] %}
    {% set owner_group = pillar['application']['groups'][grains['instance']['application']]['name'] %}
{% else %}
    {% set owner_user = 'root' %}
    {% set owner_group = 'root' %}
{% endif %}
