modules:
    python:
{% if grains['virtual_subtype'] != 'Docker' -%}
        - awscli
        - boto3
        - botocore
{% endif %}
        - python-dateutil
