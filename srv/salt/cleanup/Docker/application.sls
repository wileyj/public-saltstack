# cleanup.Docker.application
{% set application = pillar['application'] | default(None) %}
{% set os_family = grains['os_family'] | default(None) %}
{% if application %}
    {% set cleanup = pillar['application']['cleanup'] | default(None) %}
    {% if cleanup %}
        {% set packages = pillar['application']['cleanup']['packages'] | default(None) %}
        {% set modules = pillar['application']['cleanup']['modules'] | default(None) %}
        {% set dirs = pillar['application']['cleanup']['dirs'] | default(None) %}
        {% set files = pillar['application']['cleanup']['files'] | default(None) %}
        {% if modules %}
            {% set modules_python = pillar['application']['cleanup']['modules']['python'] | default(None) %}
            {% set modules_ruby = pillar['application']['cleanup']['modules']['ruby'] | default(None) %}
            {% set modules_perl = pillar['application']['cleanup']['modules']['perl'] | default(None) %}
        {% endif %}
        {% if dirs %}
            {% set dirs_delete = pillar['application']['cleanup']['dirs']['delete'] | default(None) %}
            {% set dirs_empty = pillar['application']['cleanup']['dirs']['empty'] | default(None) %}
        {% endif %}
        {% if files %}
            {% set files_delete = pillar['application']['cleanup']['files']['delete'] | default(None) %}
            {% set files_empty = pillar['application']['cleanup']['files']['empty'] | default(None) %}
        {% endif %}
        {% if packages %}
        # remove application packages
        cleanup Docker application packages:
            pkg.removed:
                - pkgs: {{ packages }}
        {% endif %}

        {% if modules and modules_python %}
        # remove application pip modules
        {% for key in modules_python %}
        cleanup pip application module {{ key }}:
            pip.removed:
                - name: {{ key }}
        {% endfor %}
        {% endif %}

        {% if modules and modules_ruby %}
        # remove application gem modules
        {% for key in modules_ruby %}
        cleanup gem application module {{ key }}:
            gem.removed:
                - name: {{ key }}
        {% endfor %}
        {% endif %}

        {% if modules and modules_perl %}
        # remove application cpan modules
        {% for key in modules_perl %}
        cleanup cpan application module {{ key }}:
            module.run:
                - name: cpan.remove
                - module: {{ key }}
        {% endfor %}
        {% endif %}

        {% if dirs and dirs_delete %}
        # remove application dirs
        {% for key in dirs_delete %}
        cleanup application dir delete - {{ key }}:
            file.directory:
                - name: {{ key }}
                - clean: True
        {% endfor %}
        {% endif %}

        {% if dirs and dirs_empty %}
        # empty application dirs
        {% for key in dirs_empty %}
        cleanup application dir empty - {{ key }}:
            file.directory:
                - name: {{ key }}
                - clean: True
        {% endfor %}
        {% endif %}

        {% if files and files_delete %}
        # remove application fiels
        {% for key in files_delete %}
        cleanup application files delete - {{ key }}:
            file.absent:
                - name: {{ key }}
        {% endfor %}
        {% endif %}
    {% endif %}
{% endif %}
