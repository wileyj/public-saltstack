include:
    - runit.packages
{% if grains['virtual_subtype'] == 'Docker' %}
    - runit.bootstrap
{% endif %}
