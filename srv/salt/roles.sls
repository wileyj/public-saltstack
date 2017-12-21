# roles

{% if 'roles' in pillar %}
include:
{% for role in pillar['roles'] %}
  - {{ role }}
{% endfor %}
{% endif %}
