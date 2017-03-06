# celery.runit
celery runit dir:
    file.directory:
        - name: /etc/service/celery
        - user: root
        - group: root
        - mode: 0755
        - makedirs: True

celery runit script:
    file.managed:
        - name: /etc/service/celery/run
        - user: root
        - group: root
        - mode: 0755
        - source: salt://runit/files/etc/service/celery/run
