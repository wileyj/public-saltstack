# php.packages
{% set packages = pillar['packages'] | default(None) %}
{% if packages %}
{% set php_packages = pillar['packages']['php'] | default(None) %}
{% if packages and php_packages %}
    global php packages:
        pkg.installed:
            - refresh: True
            - pkgs: {{ php_packages }}
{% endif %}
{% endif %}
