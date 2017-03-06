# nginx.files
nginx files - /etc/nginx/nginx.conf:
    file.managed:
        - name: /etc/nginx/nginx.conf
        - source: salt://nginx/files/etc/nginx/nginx.conf
        - user: nginx
        - group: nginx
        - mode: 644

nginx files - /etc/nginx/conf.d/logging.conf:
    file.managed:
        - name: /etc/nginx/conf.d/logging.conf
        - source: salt://nginx/files/etc/nginx/conf.d/logging.conf
        - user: nginx
        - group: nginx
        - mode: 644

nginx files - /etc/nginx/conf.d/virtual.conf:
    file.managed:
        - name: /etc/nginx/conf.d/virtual.conf
        - source: salt://nginx/files/etc/nginx/conf.d/virtual.conf
        - user: nginx
        - group: nginx
        - mode: 644

nginx files - /etc/nginx/conf.d/status.conf:
    file.managed:
        - name: /etc/nginx/conf.d/status.conf
        - source: salt://nginx/files/etc/nginx/conf.d/status.conf
        - user: nginx
        - group: nginx
        - mode: 644

nginx files - /etc/nginx/uwsgi_params:
    file.managed:
        - name: /etc/nginx/uwsgi_params
        - source: salt://nginx/files/etc/nginx/uwsgi_params
        - user: nginx
        - group: nginx
        - mode: 644

nginx files - /etc/init.d/nginx:
    file.managed:
        - name: /etc/init.d/nginx
        - source: salt://nginx/files/etc/init.d/nginx
        - user: root
        - group: root
        - mode: 0755

nginx files - /u/docroot:
    file.directory:
        - name: /u/docroot
        - user: nginx
        - group: nginx
        - mode: 755

nginx files - /u/log/nginx:
    file.directory:
        - name: /u/log/nginx
        - user: nginx
        - group: nginx
        - mode: 755

nginx files - /opt/scripts/nginx:
    file.directory:
        - name: /opt/scripts/nginx
        - user: nginx
        - group: nginx
        - mode: 755

nginx files - /etc/nginx/sites-available:
    file.directory:
        - name: /etc/nginx/sites-available
       - user: nginx
       - group: nginx
       - mode: 755

nginx files - /etc/nginx/sites-enabled:
    file.directory:
        - name: /etc/nginx/sites-enabled
       - user: nginx
       - group: nginx
       - mode: 755
