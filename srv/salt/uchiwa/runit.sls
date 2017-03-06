# uchiwa.runit
uchiwa runit dir:
    file.directory:
        - name: /etc/service/uchiwa
        - user: root
        - group: root
        - mode: 0755
        - makedirs: True

uchiwa runit script:
    file.managed:
        - name: /etc/service/uchiwa/run
        - user: root
        - group: root
        - mode: 0755
        - source: salt://runit/files/etc/service/uchiwa/run
