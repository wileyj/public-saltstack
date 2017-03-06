# application.platform
{% set application = pillar['application'] | default(None) %}
{% set owner_user = 'root' %}
{% set owner_group = 'root' %}
{% if application %}
    {% set application_users = pillar['application']['users'] | default(None) %}
    {% set application_groups = pillar['application']['groups'] | default(None) %}
    {% if application_users and application_groups %}
        {% set owner_user = pillar['application']['users'][grains['instance']['application']]['name'] | default('root') %}
        {% set owner_group = pillar['application']['groups'][grains['instance']['application']]['name'] | default('root') %}
    {% endif %}
{% endif %}

{% if grains['virtual_subtype'] == 'Docker' %}
include:
    - runit
{% endif %}
