# cleanup.EC2.init
{% set instance_grain = grains['instance'] | default(None) %}
{% if instance_grain %}
{% set role = grains['role'] | default(None) %}
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
    - .{{ grains['os_family'] }}
    - .common


{% endif %}
{% endif %}
{% endif %}
