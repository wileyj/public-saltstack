# base.files-pillar
{% set base = pillar['base'] | default(None) %}
{% set owner_user = 'root' %}
{% set owner_group = 'root' %}
{% if base %}
    {% set base_dirs = pillar['base']['dirs'] | default(None) %}
    {% set base_files = pillar['base']['files'] | default(None) %}
    {% if base_dirs %}
        {% set base_dirs_create = pillar['base']['dirs']['create'] | default(None) %}
        {% set base_dirs_delete = pillar['base']['dirs']['delete'] | default(None) %}
        {% set base_dirs_empty = pillar['base']['dirs']['empty'] | default(None) %}
        {% set base_dirs_symlink = pillar['base']['dirs']['symlink'] | default(None) %}
        # create base dirs
        {% if base_dirs and base_dirs_create %}
            {% for key in base_dirs_create %}
                base dir create - {{ key }}:
                    file.directory:
                        - name: {{ key }}
                        - user: root
                        - group: root
                        - mode: 0755
            {% endfor %}
        {% endif %}

        # delete base dirs
        {% if base_dirs and base_dirs_delete %}
            {% for key in base_dirs_delete %}
                base dir delete - {{ key }}:
                    file.absent:
                        - name: {{ key }}
            {% endfor %}
        {% endif %}

        # empty base dirs
        {% if base_dirs and base_dirs_empty %}
            {% for key in base_dirs_empty %}
                base dir empty - {{ key }}:
                    file.directory:
                        - name: {{ key }}
                        - clean: True
            {% endfor %}
        {% endif %}

        # symlink base dirs
        {% if base_dirs and base_dirs_symlink %}
            {% for key,val in base_dirs_symlink.iteritems() %}
                base dir symlink - {{ val['source'] }}:
                    file.symlink:
                        - name: {{ val['source'] }}
                        - target: {{ val['dest'] }}
            {% endfor %}
        {% endif %}
    {% endif %}
    {% if base_files %}
        {% set base_files_create = pillar['base']['files']['create'] | default(None) %}
        {% set base_files_delete = pillar['base']['files']['delete'] | default(None) %}
        {% set base_files_symlink = pillar['base']['files']['symlink'] | default(None) %}
        # create base files
        {% if base_files and base_files_create %}
            {% for key,val in base_files_create.iteritems() %}
                base file create - {{ val['source'] }}:
                    file.symlink:
                        - name: {{ val['source'] }}
                        - target: {{ val['dest'] }}
            {% endfor %}
        {% endif %}

        # delete base files
        {% if base_files and base_files_delete %}
            {% for key in base_files_delete %}
                base file delete - {{ key }}:
                    file.absent:
                        - name: {{ key }}
            {% endfor %}
        {% endif %}

        # symlink base files
        {% if base_files and base_files_symlink %}
            {% for key,val in base_files_symlink.iteritems() %}
                base file symlink - {{ val['source'] }}:
                    file.symlink:
                        - name: {{ val['source'] }}
                        - target: {{ val['dest'] }}
            {% endfor %}
        {% endif %}
    {% endif %}
{% endif %}
