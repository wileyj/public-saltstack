# rabbitmq.runit
rabbitmq runit dir:
    file.directory:
        - name: /etc/service/rabbitmq
        - user: root
        - group: root
        - mode: 0755
        - makedirs: True

rabbitmq runit script:
    file.managed:
        - name: /etc/service/rabbitmq/run
        - user: root
        - group: root
        - mode: 0755
        - source: salt://runit/files/etc/service/rabbitmq/run
