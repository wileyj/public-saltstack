# redis.packages
{% set virt = grains['virtual_subtype'] | default(True) %}
redis:
  pkg.installed:
    - name: redis
    - refresh: True
    - pkgs:
        - redis

{% if virt != 'Docker' %}
  service.running:
    - enable: True
    - restart: True
    - watch:
      - pkg: redis
      - file: /etc/redis.conf
{% endif %}
