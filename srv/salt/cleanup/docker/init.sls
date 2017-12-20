# cleanup.Docker.init
{% set instance_grain = grains['instance'] | default(None) %}
{% if instance_grain %}
    {% set role = grains['instance']['role'] | default(None) %}
    {% set application = grains['instance']['application'] | default(None) %}
    {% set cleanup = grains['instance']['cleanup'] | default(None) %}
    {% if cleanup %}
        include:
            - cleanup.{{ grains['virtual_subtype'] }}.{{ grains['os_family'] }}
            - cleanup.{{ grains['virtual_subtype'] }}.common
        {% if application %}
            - cleanup.{{ grains['virtual_subtype'] }}.application
        {% endif %}
        {% if role %}
            - cleanup.{{ grains['virtual_subtype'] }}.role
        {% endif %}
    {% endif %}
    {% if role and role == 'base' %}
        Delete Grainfile for Base instances:
            file.absent:
                - name: /etc/salt/grains

        Delete minion_id file for Base instances:
            file.absent:
                - name: /etc/salt/minion_id

        Delete minion file for Base instances:
            file.absent:
                - name: /etc/salt/minion
    {% endif %}
{% endif %}
