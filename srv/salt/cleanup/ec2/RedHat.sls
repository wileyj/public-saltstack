# cleanup.EC2.RedHat
{% set os_cleanup = pillar['os_cleanup'] | default(None) %}
{% set os_family = grains['os_family'] | default(None) %}
{% if os_cleanup %}
    {% set packages = pillar['os_cleanup']['packages'] | default(None) %}
    {% set modules = pillar['os_cleanup']['modules'] | default(None) %}
    {% set dirs = pillar['os_cleanup']['dirs'] | default(None) %}
    {% set files = pillar['os_cleanup']['files'] | default(None) %}
    {% if modules %}
        {% set modules_python = pillar['os_cleanup']['modules']['python'] | default(None) %}
        {% set modules_ruby = pillar['os_cleanup']['modules']['ruby'] | default(None) %}
        {% set modules_perl = pillar['os_cleanup']['modules']['perl'] | default(None) %}
    {% endif %}
    {% if dirs %}
        {% set dirs_delete = pillar['os_cleanup']['dirs']['delete'] | default(None) %}
        {% set dirs_empty = pillar['os_cleanup']['dirs']['empty'] | default(None) %}
    {% endif %}
    {% if files %}
        {% set files_delete = pillar['os_cleanup']['files']['delete'] | default(None) %}
        {% set files_empty = pillar['os_cleanup']['files']['empty'] | default(None) %}
    {% endif %}
{% endif %}

{% if os_cleanup and packages %}
# remove {{ os_family }}  packages
cleanup {{ os_family }} packages:
    pkg.removed:
        - pkgs: {{ packages }}
{% endif %}

{% if os_cleanup and modules and modules_python %}
# remove {{ os_family }}  pip modules
{% for key in modules_python %}
cleanup {{ os_family }} pip module {{ key }}:
    pip.removed:
        - name: {{ key }}
{% endfor %}
{% endif %}

{% if os_cleanup and modules and modules_ruby %}
# remove {{ os_family }}  gem modules
{% for key in modules_ruby %}
cleanup gem module {{ key }}:
    gem.removed:
        - name: {{ key }}
{% endfor %}
{% endif %}

{% if os_cleanup and modules and modules_perl %}
# remove {{ os_family }}  cpan modules
{% for key in modules_perl %}
cleanup cpan module {{ key }}:
    module.run:
        - name: cpan.remove
        - module: {{ key }}
{% endfor %}
{% endif %}

{% if os_cleanup and dirs and dirs_delete %}
# remove {{ os_family }}  dirs
{% for key in dirs_delete %}
cleanup {{ os_family }} dir delete - {{ key }}:
    file.directory:
        - name: {{ key }}
        - clean: True
{% endfor %}
{% endif %}

{% if os_cleanup and dirs and dirs_empty %}
# empty {{ os_family }}  dirs
{% for key in dirs_empty %}
cleanup {{ os_family }} dir empty - {{ key }}:
    file.directory:
        - name: {{ key }}
        - clean: True
{% endfor %}
{% endif %}

{% if os_cleanup and files and files_delete %}
# remove {{ os_family }}  files
{% for key in files_delete %}
cleanup {{ os_family }} files delete - {{ key }}:
    file.absent:
        - name: {{ key }}
{% endfor %}
{% endif %}
