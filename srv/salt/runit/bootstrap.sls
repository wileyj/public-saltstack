# runit.bootstrap
runit install bootstrap script:
    file.managed:
        - name: /usr/sbin/runit_bootstrap
        - user: root
        - group: root
        - mode: 0755
        - source: salt://runit/files/usr/sbin/runit_bootstrap

runit install py_init script:
    file.managed:
        - name: /bin/py_init
        - user: root
        - group: root
        - mode: 0755
        - source: salt://runit/files/bin/py_init
