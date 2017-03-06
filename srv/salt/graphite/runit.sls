# graphite.runit
graphite runit dir:
    file.directory:
        - name: /etc/service/graphite
        - user: root
        - group: root
        - mode: 0755
        - makedirs: True

graphite runit script:
    file.managed:
        - name: /etc/service/graphite/run
        - user: root
        - group: root
        - mode: 0755
        - source: salt://runit/files/etc/service/graphite/run
