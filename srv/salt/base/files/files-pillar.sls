# bastion.files-pillar
{% set role = pillar['role'] | default(None) %}
{% set owner_user = 'root' %}
{% set owner_group = 'root' %}
{% if role %}
    {% set role_dirs = pillar['role']['dirs'] | default(None) %}
    {% set role_files = pillar['role']['files'] | default(None) %}
    {% if role_dirs %}
        {% set role_dirs_create = pillar['role']['dirs']['create'] | default(None) %}
        {% set role_dirs_delete = pillar['role']['dirs']['delete'] | default(None) %}
        {% set role_dirs_empty = pillar['role']['dirs']['empty'] | default(None) %}
        {% set role_dirs_symlink = pillar['role']['dirs']['symlink'] | default(None) %}
        # create role dirs
        {% if role_dirs and role_dirs_create %}
            {% for key in role_dirs_create %}
                role dir create - {{ key }}:
                    file.directory:
                        - name: {{ key }}
                        - user: root
                        - group: root
                        - mode: 0755
            {% endfor %}
        {% endif %}

        # delete role dirs
        {% if role_dirs and role_dirs_delete %}
            {% for key in role_dirs_delete %}
                role dir delete - {{ key }}:
                    file.absent:
                        - name: {{ key }}
            {% endfor %}
        {% endif %}

        # empty role dirs
        {% if role_dirs and role_dirs_empty %}
            {% for key in role_dirs_empty %}
                role dir empty - {{ key }}:
                    file.directory:
                        - name: {{ key }}
                        - clean: True
            {% endfor %}
        {% endif %}

        # symlink role dirs
        {% if role_dirs and role_dirs_symlink %}
            {% for key,val in role_dirs_symlink.iteritems() %}
                role dir symlink - {{ val['source'] }}:
                    file.symlink:
                        - name: {{ val['source'] }}
                        - target: {{ val['dest'] }}
            {% endfor %}
        {% endif %}
    {% endif %}
    {% if role_files %}
        {% set role_files_create = pillar['role']['files']['create'] | default(None) %}
        {% set role_files_delete = pillar['role']['files']['delete'] | default(None) %}
        {% set role_files_symlink = pillar['role']['files']['symlink'] | default(None) %}
        # create role files
        {% if role_files and role_files_create %}
            {% for key,val in role_files_create.iteritems() %}
                role file create - {{ val['source'] }}:
                    file.symlink:
                        - name: {{ val['source'] }}
                        - target: {{ val['dest'] }}
            {% endfor %}
        {% endif %}

        # delete role files
        {% if role_files and role_files_delete %}
            {% for key in role_files_delete %}
                role file delete - {{ key }}:
                    file.absent:
                        - name: {{ key }}
            {% endfor %}
        {% endif %}

        # symlink role files
        {% if role_files and role_files_symlink %}
            {% for key,val in role_files_symlink.iteritems() %}
                role file symlink - {{ val['source'] }}:
                    file.symlink:
                        - name: {{ val['source'] }}
                        - target: {{ val['dest'] }}
            {% endfor %}
        {% endif %}
    {% endif %}
{% endif %}
