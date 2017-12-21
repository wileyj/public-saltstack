rabbitmq:
  vhost:
    vh_name: '/sensu'
  user:
    sensu:
      # - admin: True
      # - password: password
      - force: True
      - tags: monitoring, sensu
      - perms:
        - '/':
          - '.*'
          - '.*'
          - '.*'
      - runas: root
