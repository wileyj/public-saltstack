# base.packages
{% set os_family = grains['os_family'] | default(None) %}
{% set packages = pillar['packages'] | default(None) %}
{% if packages %}
{% set global_packages = pillar['packages']['base'] | default(None) %}
{% set redhat_packages = pillar['packages']['yum'] | default(None) %}
{% set debian_packages = pillar['packages']['apt'] | default(None) %}

{% if global_packages %}
    base packages:
      pkg.installed:
        - refresh: True
        - pkgs: {{ global_packages }}
{% endif %}

{% if os_family == 'RedHat' and redhat_packages %}
    base {{ os_family}} packages:
      pkg.installed:
        - pkgs: {{ redhat_packages }}
{% endif %}

{% if os_family == 'Debian' and debian_packages %}
    base {{ os_family}} packages:
      pkg.installed:
        - pkgs: {{ debian_packages }}
{% endif %}
{% endif %}
