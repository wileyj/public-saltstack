# source_install:openscad
{% if pillar['role'] is defined and pillar['application'] is defined and grains['instance'] is defined %}
    {% set openscad_version        = pillar['role']['openscad_version'] | default(None) %}
    {% set openscad_version_short  = pillar['role']['openscad_version_short'] | default(None) %}
    {% set openscad_version_dl_url = pillar['role']['openscad_version_dl_url'] | default(None) %}
    {% set role_users              = pillar['role']['users'] | default(None) %}
    {% set role_groups             = pillar['role']['groups'] | default(None) %}
    {% set application             = grains['instance']['application'] | default(None) %}
    {% set role                    = grains['instance']['role'] | default(None) %}
    {% set application_users       = pillar['application']['users'] | default(None) %}
    {% set application_groups      = pillar['application']['groups'] | default(None) %}

    {% if role_users and role_groups %}
        {% set owner_user          = pillar['role']['users'][grains['instance']['role']]['name'] %}
        {% set owner_group         = pillar['role']['groups'][grains['instance']['role']]['name'] %}
    {% elif application_users and application_groups %}
        {% set owner_user          = pillar['application']['users'][grains['instance']['application']]['name'] %}
        {% set owner_group         = pillar['application']['groups'][grains['instance']['application']]['name'] %}
    {% else %}
        {% set owner_user          = 'root' %}
        {% set owner_group         = 'root' %}
    {% endif %}

    {% if openscad_version and openscad_version_short and openscad_version_dl_url %}
        source_install openscad extract openscad-{{ openscad_version }}:
            archive.extracted:
                - name: /tmp
                - source: {{ openscad_version_dl_url }}
                # - tar_options: v
                - archive_format: tar
                - skip_verify: true
                - trim_output: 10
                # - user: root
                # - group: root
                - if_missing: /tmp/{{ openscad_version }}

        source_install openscad file copy - /usr/local/bin/openscad:
            file.copy:
                - name: /usr/local/bin/openscad
                - source: /tmp/{{ openscad_version }}/bin
                - dest: /usr/local/bin
                - recurse: true
                - remove_existing: true

        source_install openscad dir copy - /usr/local/lib/openscad:
            file.copy:
                - name: /usr/local/lib/openscad
                - source: /tmp/{{ openscad_version }}/lib/openscad
                - dest: /usr/local/lib
                - recurse: true
                - remove_existing: true

        source_install openscad dir copy - /usr/local/share/openscad:
            file.directory:
                - name: /usr/local/share/openscad
                - name: /usr/local/share/openscad
                - user: {{ owner_user }}
                - group: {{ owner_group }}
                - mode: 0755

        source_install openscad dir copy - /usr/local/share/openscad/libraries:
            file.copy:
                - name: /usr/local/share/openscad/libraries
                - source: /tmp/{{ openscad_version }}/libraries
                - dest: /usr/local/share/openscad
                - recurse: true
                - remove_existing: true

        source_install openscad file copy - /usr/local/share:
            file.copy:
                - name: /usr/local/share
                - source: /tmp/{{ openscad_version }}/share
                - dest: /usr/local/share/
                - recurse: true
                - remove_existing: true

        source_install openscad dir delete - /tmp/{{ openscad_version }}:
            file.absent:
                - name: /tmp/{{ openscad_version }}
    {% endif %}
{% endif %}
