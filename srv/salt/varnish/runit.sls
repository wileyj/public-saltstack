# varnish.runit
varnish runit dir:
    file.directory:
        - name: /etc/service/varnish
        - user: root
        - group: root
        - mode: 0755
        - makedirs: True

varnish runit script:
    file.managed:
        - name: /etc/service/varnish/run
        - user: root
        - group: root
        - mode: 0755
        - source: salt://runit/files/etc/service/varnish/run
