# role:ops:celery
role:
    newrelic:
        enabled: false
        packages:
    dirs:
        delete:
        empty:
        symlink:
        create:
            - /opt/celery
            - /opt/celery/tasks
    files:
        delete:
        empty:
        symlink:
        create:
    custom:
        packages:
    packages:
        - nginx
        - python-celery
        - python-flower
    modules:
        python:
        ruby:
        perl:
