# repo.init
{% set os_family = grains['os_family'] | default(None)  %}

include:
    - repo.{{ os_family }}

clean-repo:
  module.run:
    - name: pkg.refresh_db
