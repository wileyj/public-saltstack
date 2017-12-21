# denyhosts.init
include:
  - denyhosts.packages
  - denyhosts.files
  - denyhosts.templates
{% if grains['virtual_subtype'] == 'Docker' %}
  - denyhosts.runit
{% else %}
  - denyhosts.services
{% endif %}
