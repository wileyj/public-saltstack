# sensu.init
include:
  - sensu.packages
  - sensu.users
  - sensu.files
{% if grains['virtual_subtype'] == 'Docker' %}
    - sensu.runit
{% else %}
    - sensu.services
{% endif %}
