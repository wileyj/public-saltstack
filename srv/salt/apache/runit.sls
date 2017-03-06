# apache:runit
apache runit dir:
    file.directory:
        - name: /etc/service/apache
        - user: root
        - group: root
        - mode: 0755
        - makedirs: True

apache runit script:
    file.managed:
        - name: /etc/service/apache/run
        - user: root
        - group: root
        - mode: 0755
        - source: salt://runit/files/etc/service/apache/run
