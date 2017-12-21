# users.sensu
users:
  rabbitmq:
    fullname: RabbitMQ messaging server
    uid: 489
    gid: 489
    shell: /sbin/nologin
    home: /var/lib/rabbitmq
    groups:
      - rabbitmq

groups:
  rabbitmq:
    name: rabbitmq
    gid: 489
    system: False
