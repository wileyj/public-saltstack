# celery.services
celery services:
    service.running:
        - enable: True
        - reload: True
        - require:
            - pkg: python-celery
            # - watch:
            #     - file: /opt/denyhosts/etc/denyhosts.cfg
