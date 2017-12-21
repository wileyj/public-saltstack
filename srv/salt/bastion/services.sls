# bastion.services
# moved all service stuff to base formula

# {% set services = pillar['services'] | default(None) %}
# {% set role_services = pillar['services'][grains['role']] | default(None) %}
#
# {% if services and role_services %}
# {% for service, args in role_services.iteritems() %}
# {{ service }}:
#   service.{{ args['state'] }}:
#     - enable: {{ args['enabled'] }}
# {% endfor %}
# {% endif %}
