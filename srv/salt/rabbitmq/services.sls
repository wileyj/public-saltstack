# rabbitmq.services
rabbitmq services:
    service.running:
        - enable: True
        - reload: True
        - require:
            - pkg: rabbitmq
