# cleanup.EC2.common
{% set os_cleanup = pillar['common_cleanup'] | default(None) %}
{% set os_family = grains['os_family'] | default(None) %}
{% if os_cleanup %}
    {% set packages = pillar['common_cleanup']['packages'] | default(None) %}
    {% set modules = pillar['common_cleanup']['modules'] | default(None) %}
    {% set dirs = pillar['common_cleanup']['dirs'] | default(None) %}
    {% set files = pillar['common_cleanup']['files'] | default(None) %}
    {% if modules %}
        {% set modules_python = pillar['common_cleanup']['modules']['python'] | default(None) %}
        {% set modules_ruby = pillar['common_cleanup']['modules']['ruby'] | default(None) %}
        {% set modules_perl = pillar['common_cleanup']['modules']['perl'] | default(None) %}
    {% endif %}
    {% if dirs %}
        {% set dirs_delete = pillar['common_cleanup']['dirs']['delete'] | default(None) %}
        {% set dirs_empty = pillar['common_cleanup']['dirs']['empty'] | default(None) %}
    {% endif %}
    {% if files %}
        {% set files_delete = pillar['common_cleanup']['files']['delete'] | default(None) %}
        {% set files_empty = pillar['common_cleanup']['files']['empty'] | default(None) %}
    {% endif %}
{% endif %}

{% if os_cleanup and packages %}
# remove common packages
cleanup EC2 common packages:
    pkg.removed:
        - pkgs: {{ packages }}
{% endif %}

{% if os_cleanup and modules and modules_python %}
# remove common pip modules
{% for key in modules_python %}
cleanup pip module {{ key }}:
    pip.removed:
        - name: {{ key }}
{% endfor %}
{% endif %}

{% if os_cleanup and modules and modules_ruby %}
# remove common gem modules
{% for key in modules_ruby %}
cleanup gem module {{ key }}:
    gem.removed:
        - name: {{ key }}
{% endfor %}
{% endif %}

{% if os_cleanup and modules and modules_perl %}
# remove common cpan modules
{% for key in modules_perl %}
cleanup cpan module {{ key }}:
    module.run:
        - name: cpan.remove
        - module: {{ key }}
{% endfor %}
{% endif %}

{% if os_cleanup and dirs and dirs_delete %}
# remove common dirs
{% for key in dirs_delete %}
cleanup common dir delete - {{ key }}:
    file.directory:
        - name: {{ key }}
        - clean: True
{% endfor %}
{% endif %}

{% if os_cleanup and dirs and dirs_empty %}
# empty common dirs
{% for key in dirs_empty %}
cleanup common dir empty - {{ key }}:
    file.directory:
        - name: {{ key }}
        - clean: True
{% endfor %}
{% endif %}

{% if os_cleanup and files and files_delete %}
# remove common fiels
{% for key in files_delete %}
cleanup common files delete - {{ key }}:
    file.absent:
        - name: {{ key }}
{% endfor %}
{% endif %}
