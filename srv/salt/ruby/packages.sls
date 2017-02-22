{% set packages        = pillar['packages']           | default(None) %}
{% if packages %}
{% set python_packages = pillar['packages']['ruby'] | default(None) %}
{% if packages and python_packages %}
{% set ruby = pillar['packages']['ruby'] | default(None) %}
{% set rubygems = pillar['packages']['rubygems'] | default(None) %}
{% set ruby_dev = pillar['packages']['ruby-dev'] | default(None) %}
global ruby packages:
    pkg.installed:
        - pkgs:
            {% if ruby %}- {{ pillar['packages']['ruby'] }}{% endif %}
            {% if rubygems %}- {{ pillar['packages']['rubygems'] }}{% endif %}
            {% if ruby_dev %}- {{ pillar['packages']['ruby-dev'] }}{% endif %}
{% endif %}
{% endif %}
