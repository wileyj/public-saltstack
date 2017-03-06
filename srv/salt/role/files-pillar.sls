# role.files-pillar
{% set role = pillar['role'] | default(None) %}
{% set application = pillar['application'] | default(None) %}
{% set owner_user = 'root' %}
{% set owner_group = 'root' %}

{% if application %}
    {% set application_users = pillar['application']['users'] | default(None) %}
    {% set application_groups = pillar['application']['groups'] | default(None) %}
{% endif %}
{% if application %}
    {% set application_users = pillar['application']['users'] | default(None) %}
    {% set application_groups = pillar['application']['groups'] | default(None) %}
    {% if application and application_users and application_groups and grains['instance']['role'] %}
        {% set owner_user = pillar['application']['users'][grains['instance']['application']]['name'] %}
        {% set owner_group = pillar['application']['groups'][grains['instance']['application']]['name'] %}
    {% endif %}
{% endif %}
{% if role %}
    {% set role_users = pillar['role']['users'] | default(None) %}
    {% set role_groups = pillar['role']['groups'] | default(None) %}
    {% set role_dirs = pillar['role']['dirs'] | default(None) %}
    {% set role_files = pillar['role']['files'] | default(None) %}
    {% if role_users and application_groups and grains['instance']['role'] %}
        {% set owner_user = pillar['role']['users'][grains['instance']['role']]['name'] %}
        {% set owner_group = pillar['role']['groups'][grains['instance']['role']]['name'] %}
    {% endif %}
    {% if role_dirs %}
        {% set role_dirs_create = pillar['role']['dirs']['create'] | default(None) %}
        {% set role_dirs_delete = pillar['role']['dirs']['delete'] | default(None) %}
        {% set role_dirs_empty = pillar['role']['dirs']['empty'] | default(None) %}
        {% set role_dirs_symlink = pillar['role']['dirs']['symlink'] | default(None) %}
        # create role dirs
        {% if role and role_dirs and role_dirs_create %}
            {% for key in role_dirs_create %}
                role global dir create - {{ key }}:
                    file.directory:
                        - name: {{ key }}
                        - user: {{ owner_user }}
                        - group: {{ owner_group }}
                        - mode: 0755
            {% endfor %}
        {% endif %}

        # delete role dirs
        {% if role and role_dirs and role_dirs_delete %}
            {% for key in role_dirs_delete %}
                role global dir delete - {{ key }}:
                    file.absent:
                        - name: {{ key }}
            {% endfor %}
        {% endif %}

        # empty role dirs
        {% if role and role_dirs and role_dirs_empty %}
            {% for key in role_dirs_empty %}
                role global dir empty - {{ key }}:
                    file.directory:
                        - name: {{ key }}
                        - clean: True
            {% endfor %}
        {% endif %}

        # symlink role dirs
        {% if role and role_dirs and role_dirs_symlink %}
            {% for key,val in role_dirs_symlink.iteritems() %}
                role global dir symlink - {{ val['source'] }}:
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
        {% if role and role_files and role_files_create %}
            {% for key,val in role_files_create.iteritems() %}
                role global file create - {{ val['source'] }}:
                    file.symlink:
                        - name: {{ val['source'] }}
                        - target: {{ val['dest'] }}
            {% endfor %}
        {% endif %}

        # delete role files
        {% if role and role_files and role_files_delete %}
            {% for key in role_files_delete %}
                role global file delete - {{ key }}:
                    file.absent:
                        - name: {{ key }}
            {% endfor %}
        {% endif %}

            # symlink role files
        {% if role and role_files and role_files_symlink %}
            {% for key in role_files_symlink.iteritems() %}
                role global file symlink - {{ val['source'] }}:
                    file.symlink:
                        - name: {{ val['source'] }}
                        - target: {{ val['dest'] }}
            {% endfor %}
        {% endif %}
    {% endif %}
{% endif %}
