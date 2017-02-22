runit install bootstrap script:
    file.managed:
        - name: /usr/sbin/runit_bootstrap
        - user: root
        - group: root
        - mode: 0755
        - source: salt://runit/files/usr/sbin/runit_bootstrap
