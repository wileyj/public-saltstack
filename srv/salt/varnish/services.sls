# varnish.services
{% set virt = grains['virtual_subtype'] | default(True) %}
{% if virt != 'Docker' %}
varnish services:
    varnish.running:
        - require:
            - pkg: varnish.packages
{% endif %}
