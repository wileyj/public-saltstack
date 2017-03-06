# denyhosts.init
include:
  - denyhosts.packages
  - denyhosts.files
{% if grains['virtual_subtype'] == 'Docker' %}
    - denyhosts.runit
{% else %}
    - denyhosts.services
{% endif %}
