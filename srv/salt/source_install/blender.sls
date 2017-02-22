# source_install:blender
{% if pillar['role'] is defined and pillar['application'] is defined and grains['instance'] is defined %}
    {% set blender_version        = pillar['role']['blender_version'] | default(None) %}
    {% set blender_version_short  = pillar['role']['blender_version_short'] | default(None) %}
    {% set blender_version_dl_url = pillar['role']['blender_version_dl_url'] | default(None) %}
    {% set role_users             = pillar['role']['users'] | default(None) %}
    {% set role_groups            = pillar['role']['groups'] | default(None) %}
    {% set application            = grains['instance']['application'] | default(None) %}
    {% set role                   = grains['instance']['role'] | default(None) %}
    {% set application_users      = pillar['application']['users'] | default(None) %}
    {% set application_groups     = pillar['application']['groups'] | default(None) %}

    {% if role_users and role_groups %}
        {% set owner_user         = pillar['role']['users'][grains['instance']['role']]['name'] %}
        {% set owner_group        = pillar['role']['groups'][grains['instance']['role']]['name'] %}
    {% elif application_users and application_groups %}
        {% set owner_user         = pillar['application']['users'][grains['instance']['application']]['name'] %}
        {% set owner_group        = pillar['application']['groups'][grains['instance']['application']]['name'] %}
    {% else %}
        {% set owner_user         = 'root' %}
        {% set owner_group        = 'root' %}
    {% endif %}

    {% if blender_version and blender_version_short and blender_version_dl_url %}
        source_install blender extract  blender-{{ blender_version }}:
            archive.extracted:
                - name: /opt/
                - source: {{ blender_version_dl_url }}
                - options: j
                - archive_format: tar
                - skip_verify: true
                - trim_output: 10
                - user: {{ owner_user }}
                - group: {{ owner_group }}
                - if_missing: /opt/{{ blender_version }}

        source_install blender dir symlink - /opt/blender:
            file.symlink:
                - name: /opt/blender
                - target: /opt/{{ blender_version }}

        source_install blender dir symlink /opt/blender/cur-ver:
            file.symlink:
                - name: /opt/blender/cur-ver
                - target: /opt/{{ blender_version }}/{{ blender_version_short }}

        {% if role and application %}
        source_install blender file create - /opt/blender/cur-ver/scripts/addons/io_mesh_stl/stl_utils.py:
            file.managed:
                - name: /opt/blender/cur-ver/scripts/addons/io_mesh_stl/stl_utils.py
                - source: salt://role/{{ application }}/files/{{ role }}/stl_utils.py
                - user: {{ owner_user }}
                - group: {{ owner_group }}
                - mode: 0755
                - replace: true
        {% endif %}
    {% endif %}
{% endif %}
