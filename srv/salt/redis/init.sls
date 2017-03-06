# redis.init
include:
    - redis.users
    - redis.packages
    - redis.files
{% if grains['virtual_subtype'] == 'Docker' %}
    - redis.runit
{% else %}
    - redis.services
{% endif %}
