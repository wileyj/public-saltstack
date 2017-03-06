# nginx.runit
nginx runit dir:
    file.directory:
        - name: /etc/service/nginx
        - user: root
        - group: root
        - mode: 0755
        - makedirs: True

nginx runit script:
    file.managed:
        - name: /etc/service/nginx/run
        - user: root
        - group: root
        - mode: 0755
        - source: salt://runit/files/etc/service/nginx/run
