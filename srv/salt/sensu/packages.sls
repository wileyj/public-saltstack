{% set client_packages = pillar['sensu']['packages']['client'] | default(None) %}
{% set role = grains['role'] | default(None) %}

client-packages:
  pkg.installed:
    - refresh: True
    - pkgs: {{ client_packages }}

{% if role == 'sensu' %}
{% set server_packages = pillar['sensu']['packages']['server'] | default(None) %}
server-packages:
  pkg.installed:
    - refresh: True
    - pkgs: {{ server_packages }}
{% endif %}
