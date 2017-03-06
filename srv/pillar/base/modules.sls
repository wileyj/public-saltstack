# base.modules
modules:
    python:
        - python-dateutil
{% if grains['virtual_subtype'] != 'Docker' %}
        - awscli
        - boto3
        - botocore
{% endif %}
