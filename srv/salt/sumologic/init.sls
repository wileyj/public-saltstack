# sumologic.init
include:
    - sumologic.users
    - sumologic.packages
    - sumologic.files
{% if grains['virtual_subtype'] == 'Docker' %}
    - sumologic.runit
{% else %}
    - sumologic.services
{% endif %}
