include:
  - nginx

extend:
  nginx:
    service:
      - watch:
        - pip: uWSGI
        - pip: uwsgi-metrics
        - pip: wsgi-request-logger

python27-pip:
  pkg.installed

install_uWSGI:
  pip.installed:
    - name: uWSGI
    - upgrade: True

install_wsgi_metrics:
  pip.installed:
    - name: uwsgi-metrics
    - upgrade: True

install_wsgi-request-logger:
  pip.installed:
    - name: wsgi-request-logger
    - upgrade: True
