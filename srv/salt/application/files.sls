{% set application = pillar['application'] | default(None) %}
{% if application %}
    {% set application_dirs = pillar['application']['dirs'] | default(None) %}
    {% set application_files = pillar['application']['files'] | default(None) %}
    {% set application_users = pillar['application']['users'] | default(None) %}
    {% set application_groups = pillar['application']['groups'] | default(None) %}
    {% if application_dirs %}
        {% set application_dirs_create = pillar['application']['dirs']['create'] | default(None) %}
        {% set application_dirs_delete = pillar['application']['dirs']['delete'] | default(None) %}
        {% set application_dirs_empty = pillar['application']['dirs']['empty'] | default(None) %}
        {% set application_dirs_symlink = pillar['application']['dirs']['symlink'] | default(None) %}
    {% endif %}
    {% if application_files %}
        {% set application_files_create = pillar['application']['files']['create'] | default(None) %}
        {% set application_files_delete = pillar['application']['files']['delete'] | default(None) %}
        {% set application_files_symlink = pillar['application']['files']['symlink'] | default(None) %}
    {% endif %}
{% endif %}

{% if application and application_users and application_groups %}
    {% set owner_user = pillar['application']['users'][grains['instance']['application']]['name'] %}
    {% set owner_group = pillar['application']['groups'][grains['instance']['application']]['name'] %}
{% else %}
    {% set owner_user = 'root' %}
    {% set owner_group = 'root' %}
{% endif %}

# application dirs
{% if application and application_dirs %}
    # create application dirs
    {% if application and application_dirs and application_dirs_create %}
        {% for key in application_dirs_create %}
            application dir create - {{ key }}:
                file.directory:
                    - name: {{ key }}
                    - user: {{ owner_user }}
                    - group: {{ owner_group }}
                    - mode: 0755
        {% endfor %}
    {% endif %}

    # delete application dirs
    {% if application and application_dirs and application_dirs_delete %}
        {% for key in application_dirs_delete %}
            application dir delete - {{ key }}:
                file.absent:
                    - name: {{ key }}
        {% endfor %}
    {% endif %}

    # empty application dirs
    {% if application and application_dirs and application_dirs_empty %}
        {% for key in application_dirs_empty %}
            application dir empty - {{ key }}:
                file.directory:
                    - name: {{ key }}
                    - clean: True
        {% endfor %}
    {% endif %}

    # symlink application dirs
    {% if application and application_dirs and application_dirs_symlink %}
        {% for key,val in application_dirs_symlink.iteritems() %}
            application dir empty - {{ val['source'] }}:
                file.symlink:
                    - name: {{ val['source'] }}
                    - target: {{ val['dest'] }}
        {% endfor %}
    {% endif %}
{% endif %}

# application files
{% if application and application_files %}
    # create application files
    {% if application and application_files and application_files_create %}
        {% for key,val in application_files_create.iteritems() %}
            application file create - { val['source'] }}:
                file.symlink:
                    - name: {{ val['source'] }}
                    - target: {{ val['dest'] }}
        {% endfor %}
    {% endif %}

    # delete application files
    {% if application and application_files and application_files_delete %}
        {% for key in application_files_delete %}
            application file delete - {{ key }}:
                file.absent:
                    - name: {{ key }}
        {% endfor %}
    {% endif %}

        # symlink application files
    {% if application and application_files and application_files_symlink %}
        {% for key in application_files_symlink.iteritems() %}
            application file symlink - {{ val['source'] }}:
                file.symlink:
                    - name: {{ val['source'] }}
                    - target: {{ val['dest'] }}
        {% endfor %}
    {% endif %}
{% endif %}
