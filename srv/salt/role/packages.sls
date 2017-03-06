# role.packages
{% set role = pillar['role'] | default(None) %}
{% if role %}
{% set packages = pillar['role']['packages'] | default(None) %}
{% if role and packages  %}
role global packages:
    pkg.installed:
        - refresh: true
        - pkgs: {{ packages }}
{% endif %}
{% endif %}
