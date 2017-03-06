# squid.services
{% set virt = grains['virtual_subtype'] | default(True) %}
{% if virt != 'Docker' %}
squid services:
    service.running:
        - require:
            - pkg: squid.packages
{% endif %}
