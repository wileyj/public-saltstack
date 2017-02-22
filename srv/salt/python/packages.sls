{% set packages        = pillar['packages']           | default(None) %}
{% if packages %}
{% set python_packages = pillar['packages']['python'] | default(None) %}
{% if packages and python_packages %}
{% set python = pillar['packages']['python'] | default(None) %}
{% set python_setuptools = pillar['packages']['python-setuptools'] | default(None) %}
{% set python_pip = pillar['packages']['python-pip'] | default(None) %}
    global python packages:
        pkg.installed:
            - refresh: True
            - pkgs:
                {% if python %}- {{ pillar['packages']['python'] }}{% endif %}
                {% if python_setuptools %}- {{ pillar['packages']['python-setuptools'] }}{% endif %}
                {% if python_pip %}- {{ pillar['packages']['python-pip'] }}{% endif %}
{% endif %}
{% endif %}
