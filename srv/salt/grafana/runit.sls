# grafana.runit
grafana runit dir:
    file.directory:
        - name: /etc/service/grafana
        - user: root
        - group: root
        - mode: 0755
        - makedirs: True

grafana runit script:
    file.managed:
        - name: /etc/service/grafana/run
        - user: root
        - group: root
        - mode: 0755
        - source: salt://runit/files/etc/service/grafana/run
