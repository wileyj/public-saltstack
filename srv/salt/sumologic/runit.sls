# sumologic.runit
sumologic runit dir:
    file.directory:
        - name: /etc/service/sumologic
        - user: root
        - group: root
        - mode: 0755
        - makedirs: True

sumologic runit script:
    file.managed:
        - name: /etc/service/sumologic/run
        - user: root
        - group: root
        - mode: 0755
        - source: salt://runit/files/etc/service/sumologic/run
