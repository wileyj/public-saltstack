{% set packages      = pillar['packages']         | default(None) %}
{% if packages %}
{% set perl_packages = pillar['packages']['perl'] | default(None) %}
{% if packages and perl_packages %}
    global perl packages:
        pkg.installed:
            - refresh: True
            - pkgs: {{ perl_packages }}
{% endif %}
{% endif %}
