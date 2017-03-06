# celery.init
include:
    - celery.packages
{% if grains['virtual_subtype'] == 'Docker' %}
    - celery.runit
{% else %}
    - celery.services
{% endif %}
