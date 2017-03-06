# postgres.services
{% set virt = grains['virtual_subtype'] | default(True) %}
{% if virt != 'Docker' %}
postgres services:
    service.running:
        - require:
            - pkg: postgres.packages

{% endif %}
