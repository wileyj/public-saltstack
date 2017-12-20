# cleanup.Docker.role
{% set role = pillar['role'] | default(None) %}
{% set os_family = grains['os_family'] | default(None) %}
{% if role %}
    {% set cleanup = pillar['role']['cleanup'] | default(None) %}
    {% if cleanup %}
        {% set packages = pillar['role']['cleanup']['packages'] | default(None) %}
        {% set modules = pillar['role']['cleanup']['modules'] | default(None) %}
        {% set dirs = pillar['role']['cleanup']['dirs'] | default(None) %}
        {% set files = pillar['role']['cleanup']['files'] | default(None) %}
        {% if modules %}
            {% set modules_python = pillar['role']['cleanup']['modules']['python'] | default(None) %}
            {% set modules_ruby = pillar['role']['cleanup']['modules']['ruby'] | default(None) %}
            {% set modules_perl = pillar['role']['cleanup']['modules']['perl'] | default(None) %}
        {% endif %}
        {% if dirs %}
            {% set dirs_delete = pillar['role']['cleanup']['dirs']['delete'] | default(None) %}
            {% set dirs_empty = pillar['role']['cleanup']['dirs']['empty'] | default(None) %}
        {% endif %}
        {% if files %}
            {% set files_delete = pillar['role']['cleanup']['files']['delete'] | default(None) %}
            {% set files_empty = pillar['role']['cleanup']['files']['empty'] | default(None) %}
        {% endif %}
        {% if packages %}
        # remove role packages
        cleanup Docker role packages:
            pkg.removed:
                - pkgs: {{ packages }}
        {% endif %}

        {% if modules and modules_python %}
        # remove role pip modules
        {% for key in modules_python %}
        cleanup pip role module {{ key }}:
            pip.removed:
                - name: {{ key }}
        {% endfor %}
        {% endif %}

        {% if modules and modules_ruby %}
        # remove role gem modules
        {% for key in modules_ruby %}
        cleanup gem role module {{ key }}:
            gem.removed:
                - name: {{ key }}
        {% endfor %}
        {% endif %}

        {% if modules and modules_perl %}
        # remove role cpan modules
        {% for key in modules_perl %}
        cleanup cpan role module {{ key }}:
            module.run:
                - name: cpan.remove
                - module: {{ key }}
        {% endfor %}
        {% endif %}

        {% if dirs and dirs_delete %}
        # remove role dirs
        {% for key in dirs_delete %}
        cleanup role dir delete - {{ key }}:
            file.directory:
                - name: {{ key }}
                - clean: True
        {% endfor %}
        {% endif %}

        {% if dirs and dirs_empty %}
        # empty role dirs
        {% for key in dirs_empty %}
        cleanup role dir empty - {{ key }}:
            file.directory:
                - name: {{ key }}
                - clean: True
        {% endfor %}
        {% endif %}

        {% if files and files_delete %}
        # remove role fiels
        {% for key in files_delete %}
        cleanup role files delete - {{ key }}:
            file.absent:
                - name: {{ key }}
        {% endfor %}
        {% endif %}
    {% endif %}
{% endif %}
