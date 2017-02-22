# varnish:init
include:
    - varnish.files
{% if grains['virtual_subtype'] == 'Docker' %}
    - varnish.runit
{% endif %}
