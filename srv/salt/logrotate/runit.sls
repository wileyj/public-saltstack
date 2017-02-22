logrotate runit dir:
    file.directory:
        - name: /etc/service/logrotate
        - user: root
        - group: root
        - mode: 0755
        - makedirs: True

logrotate runit script:
    file.managed:
        - name: /etc/service/logrotate/run
        - user: root
        - group: root
        - mode: 0755
        - source: salt://runit/files/etc/service/logrotate/run
