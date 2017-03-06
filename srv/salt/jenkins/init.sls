# jenkins.init
include:
    - jenkins.packages
{% if grains['virtual_subtype'] == 'Docker' %}
    - jenkins.runit
{% else %}
    - jenkins.services
{% endif %}
