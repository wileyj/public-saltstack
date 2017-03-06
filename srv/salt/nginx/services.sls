# nginx.services
{% set virt = grains['virtual_subtype'] | default(True) %}
{% if virt != 'Docker' %}
nginx services:
    service.running:
        - require:
            - pkg: nginx.packages
        - watch:
            - file: /etc/nginx/nginx.conf
{% endif %}
