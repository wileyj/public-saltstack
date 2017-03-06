# application.init
{% set instance = grains['instance'] | default(None) %}
{% if instance %}
{% set application = grains['instance']['application'] | default(None) %}
{% endif %}

include:
    - application/users
{% if application %}
    - application/{{ application }}
{% endif %}
    # - application/files
    - role/users
    - role/packages
    # - role/files
    - role
