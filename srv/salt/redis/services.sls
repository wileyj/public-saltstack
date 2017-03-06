# redis.services
{% set virt = grains['virtual_subtype'] | default(True) %}
{% if virt != 'Docker' %}
redis services:
    service.running:
        - require:
            - pkg: redis.packages
{% endif %}
