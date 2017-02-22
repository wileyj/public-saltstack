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

python install uWSGI:
    pip.installed:
        - name: uWSGI
        - upgrade: True

python install pip uwsgi_metrics:
    pip.installed:
        - name: uwsgi-metrics
        - upgrade: True

python install pip uwsgi-request-logger:
    pip.installed:
        - name: wsgi-request-logger
        - upgrade: True
