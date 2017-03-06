# redis.runit
redis runit dir:
    file.directory:
        - name: /etc/service/redis
        - user: root
        - group: root
        - mode: 0755
        - makedirs: True

redis runit script:
    file.managed:
        - name: /etc/service/redis/run
        - user: root
        - group: root
        - mode: 0755
        - source: salt://runit/files/etc/service/redis/run
