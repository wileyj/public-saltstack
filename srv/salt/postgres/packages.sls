# postgres.packages
{% set packages = pillar['postgres']['pacakges'] | default(None) %}
{% if packages %}
postgres packages:
    pkg.installed:
        - refresh: True
        - pkgs: {{ packages }}
{% endif %}
