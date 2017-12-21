# cleanup.Docker.init
{% if grains["virtual_subtype"]  == "Xen PV DomU" %}
{% set virt = "EC2" %}
{% else %}
{% set virt = grains['virtual_subtype'] | default(None)  %}
{% endif %}
{% set instance_grain = grains['instance'] | default(None) %}
{% if instance_grain %}
    {% set role = grains['role'] | default(None) %}
    {% set application = grains['application'] | default(None) %}
    {% set cleanup = grains['instance']['cleanup'] | default(None) %}
    {% if cleanup %}
        include:
            - cleanup.{{ virt }}.{{ grains['os_family'] }}
            - cleanup.{{ virt }}.common
        {% if application %}
            - cleanup.{{ virt }}.application
        {% endif %}
        {% if role %}
            - cleanup.{{ virt }}.role
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
