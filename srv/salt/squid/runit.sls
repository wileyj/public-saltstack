# squid.unit
squid runit dir:
    file.directory:
        - name: /etc/service/squid
        - user: root
        - group: root
        - mode: 0755
        - makedirs: True

squid runit script:
    file.managed:
        - name: /etc/service/squid/run
        - user: root
        - group: root
        - mode: 0755
        - source: salt://runit/files/etc/service/squid/run
