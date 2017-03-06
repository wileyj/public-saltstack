# runit.packages
global runit packages:
    pkg.installed:
        - refresh: True
        - pkgs:
            - runit
        {% if grains['os_family'] == 'RedHat' %}
            - docker-init
        {% endif %}
