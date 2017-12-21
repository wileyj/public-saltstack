# python.modules
{% set modules = pillar['modules'] | default(None) %}

{% set base_python_modules = pillar['modules']['base']['python'] | default(None) %}
{% if modules and base_python_modules %}
python_modules:
  pip.installed:
    - pkgs: {{ base_python_modules }}
    - upgrade: True
    - ignore_installed: True
{% endif %}

#
# golang should go here
#
#

{% set base_ruby_modules = pillar['modules']['base']['ruby'] | default(None) %}
{% if modules and base_ruby_modules %}
ruby_modules:
  gem.installed:
    - names: {{ base_ruby_modules }}
{% endif -%}

{% set base_perl_modules = pillar['modules']['base']['perl'] | default(None) %}
{% if modules and base_perl_modules %}
cpan_env:
   environ.setenv:
     - name: PERL_MM_USE_DEFAULT
     - value: "1"

/root/.cpan:
    file.directory:
        - user: root
        - group: root
        - mode: 0755

/root/.cpan/build:
    file.directory:
        - user: root
        - group: root
        - mode: 0755

{% for module in base_perl_modules %}
  {{ module }}:
    module.run:
      - name: cpan.install
      - module: {{ module }}
{% endfor %}
{% endif %}
