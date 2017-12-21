# sensu.services
{% set virt = grains['virtual_subtype'] | default(True) %}
{% set role = grains['role'] | default(None) %}
{% if virt != 'Docker' %}
sensu-client:
  service.running:
    - enable: True
    - watch:
      # - file: /etc/init.d/sensu-client
      - file: /etc/sensu/conf.d/client.json
      - file: /etc/sensu/conf.d/services/api.json
      - file: /etc/sensu/conf.d/services/redis.json
      - file: /etc/sensu/conf.d/services/rabbitmq.json
      - file: /etc/sensu/conf.d/relay.json
      - file: /etc/sensu/conf.d/handlers/graphite.json
      - file: /etc/sensu/conf.d/handlers/graphite_line_tcp.json
{% endif %}
{% if role == 'sensu' %}
sensu-server:
  service.running:
    - enable: True
    - watch:
      # - file: /etc/init.d/sensu-server
      - file: /etc/sensu/config.json

sensu-api:
  service.running:
    - enable: True
    - watch:
      # - file: /etc/init.d/sensu-api
      - file: /etc/sensu/config.json

# sensu-service:
#   service.running:
#     - enable: True
#     - watch:
#       - file: /etc/init.d/sensu-service
{% endif %}
