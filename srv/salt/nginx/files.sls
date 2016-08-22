/etc/nginx/nginx.conf:
  file.managed:
    - source: salt://nginx/files/etc/nginx/nginx.conf
    - user: nginx
    - group: nginx
    - mode: 644

/etc/nginx/conf.d/logging.conf:
  file.managed:
    - source: salt://nginx/files/etc/nginx/conf.d/logging.conf
    - user: nginx
    - group: nginx
    - mode: 644

/etc/nginx/conf.d/virtual.conf:
  file.managed:
    - source: salt://nginx/files/etc/nginx/conf.d/virtual.conf
    - user: nginx
    - group: nginx
    - mode: 644

/etc/nginx/conf.d/status.conf:
  file.managed:
    - source: salt://nginx/files/etc/nginx/conf.d/status.conf
    - user: nginx
    - group: nginx
    - mode: 644

/etc/nginx/uwsgi_params:
  file.managed:
    - source: salt://nginx/files/etc/nginx/uwsgi_params
    - user: nginx
    - group: nginx
    - mode: 644

/etc/init.d/nginx:
  file.managed:
    - source: salt://nginx/files/etc/init.d/nginx
    - user: root
    - group: root
    - mode: 0755

/u/docroot:
  file.directory:
    - user: nginx
    - group: nginx
    - mode: 755

/u/log/nginx:
  file.directory:
    - user: nginx
    - group: nginx
    - mode: 755

/opt/scripts/nginx:
  file.directory:
    - user: nginx
    - group: nginx
    - mode: 755

/etc/nginx/sites-available:
  file.directory:
   - user: nginx
   - group: nginx
   - mode: 755

/etc/nginx/sites-enabled:
  file.directory:
   - user: nginx
   - group: nginx
   - mode: 755
