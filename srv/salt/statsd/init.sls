# statsd.init
include:
    - statsd.users
    - statsd.packages
    - statsd.files
{% if grains['virtual_subtype'] == 'Docker' %}
    - statsd.runit
{% else %}
    - statsd.services
{% endif %}
