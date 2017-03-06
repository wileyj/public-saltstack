# uchiwa.init
include:
  - uchiwa.packages
  - uchiwa.files
  - uchiwa.users
{% if grains['virtual_subtype'] == 'Docker' %}
    - uchiwa.runit
{% else %}
    - uchiwa.services
{% endif %}
