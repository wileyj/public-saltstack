include:
  - repo.{{ grains['os_family'] }}.rabbitmq
  - rabbitmq.server
  - rabbitmq.config
  - rabbitmq.plugins
  - rabbitmq.rabbit-management
