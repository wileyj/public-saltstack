# statsd.runit
statsd runit dir:
    file.directory:
        - name: /etc/service/statsd
        - user: root
        - group: root
        - mode: 0755
        - makedirs: True

statsd runit script:
    file.managed:
        - name: /etc/service/statsd/run
        - user: root
        - group: root
        - mode: 0755
        - source: salt://runit/files/etc/service/statsd/run
