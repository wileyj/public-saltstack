# base.enabled-services
{% set services = pillar['services'] | default(None) %}
{% set base_services = pillar['services'] | default(None) %}
# {% set base_services = pillar['services']['base'] | default(None) %}

{% if services and base_services %}
{% for service, args in base_services.iteritems() %}
{{ service }}:
  service.{{ args['state'] }}:
    - enable: {{ args['enabled'] }}
{% endfor %}
{% endif %}

# auditd:
#   service.running:
#     - enable: True
# cloud-config:
#   service.running:
#     - enable: True
# cloud-final:
#   service.running:
#     - enable: True
# cloud-init:
#   service.running:
#     - enable: True
# cloud-init-local:
#   service.running:
#     - enable: True
# messagebus:
#   service.running:
#     - enable: True
# crond:
#   service.running:
#     - enable: True
# network:
#   service.running:
#     - enable: True
# ntpd:
#   service.running:
#     - enable: True
# rsyslog:
#   service.running:
#     - enable: True
# sysstat:
#   service.running:
#     - enable: True
# # udev-post:
# #   service.running:
# #     - enable: True
