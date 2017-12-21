# bastion.packages
{% set bastion_packages = pillar['packages'][grains['role']] | default(None) %}
{% if bastion_packages != 'None' %}
    bastion packages:
      pkg.installed:
        - refresh: True
        - pkgs: {{ bastion_packages }}
{% endif %}
