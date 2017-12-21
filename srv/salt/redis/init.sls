# redis.init
include:
    - redis.server
    - redis.files
    - redis.config
{% if grains['virtual_subtype'] == 'Docker' %}
    - redis.runit
{% endif %}
