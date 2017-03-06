# nginx.init
include:
  - nginx.packages
  - nginx.users
  - nginx.files
{% if grains['virtual_subtype'] == 'Docker' %}
    - nginx.runit
{% else %}
    - nginx.services
{% endif %}
  - nginx.sysctl
