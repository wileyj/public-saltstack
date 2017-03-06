# runit.init
{% if grains['os_family'] == 'RedHat' %}
include:
    - runit.packages
{% if grains['virtual_subtype'] == 'Docker' %}
    - runit.bootstrap
{% endif %}
{% endif %}
