# base.packages
{% set packages = pillar['packages'] | default(None) %}

{% set base_packages = pillar['packages']['base'] | default(None) %}
{% if packages and base_packages%}
base_packages:
  pkg.installed:
    - refresh: True
    - pkgs: {{ base_packages }}
{% endif %}

{% set os_packages = pillar['packages']['os'] | default(None) %}
{% if packages and os_packages %}
base_os_packages:
  pkg.installed:
    - refresh: True
    - pkgs: {{ os_packages }}
{% endif %}

{% set python_packages = pillar['packages']['python'] | default(None) %}
{% if packages and python_packages %}
python_packages:
  pkg.installed:
    - refresh: True
    - pkgs: {{ python_packages }}
{% endif %}

{% set perl_packages = pillar['packages']['perl'] | default(None) %}
{% if packages and perl_packages %}
perl_packages:
  pkg.installed:
    - refresh: True
    - pkgs: {{ perl_packages }}
{% endif %}

{% set ruby_packages = pillar['packages']['ruby'] | default(None) %}
{% if packages and ruby_packages %}
ruby_packages:
  pkg.installed:
    - refresh: True
    - pkgs: {{ ruby_packages }}
{% endif %}
