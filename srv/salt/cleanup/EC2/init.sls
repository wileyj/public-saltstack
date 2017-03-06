# cleanup.EC2.init
{% set instance_grain = grains['instance'] | default(None) %}
{% if instance_grain %}
{% set role = grains['instance']['role'] | default(None) %}
{% set cleanup = grains['instance']['cleanup'] | default(None) %}
{% if cleanup %}
Delete minion_id file:
    file.absent:
        - name: /etc/salt/minion_id
{% if role and role == 'base' %}
Delete Grainfile for Base instances:
    file.absent:
        - name: /etc/salt/grains
{% else %}
include:
    - cleanup.{{ grains['virtual_subtype'] }}.{{ grains['os_family'] }}
    - cleanup.{{ grains['virtual_subtype'] }}.common
{% endif %}
{% endif %}
{% endif %}
