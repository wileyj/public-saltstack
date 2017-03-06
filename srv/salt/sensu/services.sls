# sensu.services
{% set virt = grains['virtual_subtype'] | default(True) %}
{% if virt != 'Docker' %}
sensu services:
    service.running:
        - require:
            - pkg: sensu.packages
{% endif %}
