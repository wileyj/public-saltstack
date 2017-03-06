# postgres.runit
postgres runit dir:
    file.directory:
        - name: /etc/service/postgres
        - user: root
        - group: root
        - mode: 0755
        - makedirs: True

postgres runit script:
    file.managed:
        - name: /etc/service/postgres/run
        - user: root
        - group: root
        - mode: 0755
        - source: salt://runit/files/etc/service/postgres/run
