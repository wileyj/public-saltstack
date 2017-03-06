# java.packages
{% set packages = pillar['packages']['jdk'] | default(None) %}
{% if packages %}
    java packages:
      pkg.installed:
        - refresh: True
        - pkgs: {{ packages }}
{% endif %}
