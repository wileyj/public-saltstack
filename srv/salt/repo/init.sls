# repo.init
{% set os_family = grains['os_family'] | default(None)  %}

include:
    - repo.{{ os_family }}
