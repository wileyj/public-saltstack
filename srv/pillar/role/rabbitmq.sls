roles:
packages:
  rabbitmq:
    - rabbitmq-server
rabbitmq:
  enabled: True
  running: True
  plugin:
    rabbitmq_management:
      - enabled
  # policy:
  #   rabbitmq_policy:
  #     - name: HA
  #     - pattern: '.*'
  #     - definition: '{"ha-mode": "all"}'
  # vhost:
  #   vh_name: '/virtual/host'
  user:
    admin:
      # - password: admin
      - force: True
      - tags: administrator
      - perms:
        - '/':
          - '.*'
          - '.*'
          - '.*'
      - runas: root
  #   user2:
  #     - password: password
  #     - force: True
  #     - tags: monitoring, user
  #     - perms:
  #       - '/':
  #         - '.*'
  #         - '.*'
  #         - '.*'
  #     - runas: root
