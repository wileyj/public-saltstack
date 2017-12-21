# sensu.init
{% set role = grains['role'] | default(None) %}

include:
  - sensu.packages
  - sensu.client
{% if role == 'sensu' %}
  - sensu.server
{% endif %}
  - sensu.services
