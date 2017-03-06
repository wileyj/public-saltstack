# uchiwa.services
{% set virt = grains['virtual_subtype'] | default(True) %}
{% if virt != 'Docker' %}
uchiwa services:
    service.running:
        - require:
            - pkg: uchiwa.packages
{% endif %}
