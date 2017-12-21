# base.modules
modules:
  base:
    python:
      - python-dateutil
  {% if grains['virtual_subtype'] != 'Docker' or grains['virtual_subtype'] != 'docker' %}
      - awscli
      - boto3
      - botocore
  {% endif %}
    ruby:
    perl:
    golang:
