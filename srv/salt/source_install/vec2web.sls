{% if pillar['role'] is defined and pillar['application'] is defined and grains['instance'] is defined %}
{% set vec2web_version        = pillar['role']['vec2web_version'] | default(None) %}
{% set vec2web_version_short  = pillar['role']['vec2web_version_short'] | default(None) %}
{% set vec2web_version_dl_url = pillar['role']['vec2web_version_dl_url'] | default(None) %}

    {% if vec2web_version and vec2web_version_short and vec2web_version_dl_url %}
        source_install vec2web extract - vec2web-{{ vec2web_version }}:
            archive.extracted:
                - name: /tmp
                - source: {{ vec2web_version_dl_url }}
                # - tar_options: v
                - archive_format: tar
                - skip_verify: true
                - trim_output: 10
                # - user: root
                # - group: root
                - if_missing: /tmp/{{ vec2web_version }}.src

        source_install vec2web file edit - /tmp/{{ vec2web_version }}.src/dxflib/src/dl_writer_ascii.cpp:
            file.line:
                - content: "#include <string.h>\n"
                - mode: insert
                - location: start
                - indent: true

        source_install vec2web file edit - /tmp/{{ vec2web_version }}.src/dxflib/src/dl_writer.h:
            file.line:
                - content: "#include <string.h>\n"
                - mode: insert
                - location: start
                - indent: true

        source_install vec2web file edit - /tmp/{{ vec2web_version }}.src/qcadlib/src/information/rs_information.cpp:
            file.line:
                - content: "#include <stdlib.h>\n"
                - mode: insert
                - location: start
                - indent: true

        source_install vec2web file edit - /tmp/{{ vec2web_version }}.src/qcadlib.diff:
            file.managed:
                - name: /tmp/{{ vec2web_version }}.src/qcadlib.diff
                - source: salt://source_install/files/vec2web/qcadlib.diff
                # - user: root
                # - group: root
                - mode: 0644
                - replace: true

        source_install vec2web file patch - /tmp/{{ vec2web_version }}.src:
            cmd.run:
                - cwd: /tmp/{{ vec2web_version }}.src
                - name: patch -p1 < qcadlib.diff

        source_install vec2web build - vec2web-{{ vec2web_version }}:
            cmd.run:
                - cwd: /tmp/{{ vec2web_version }}.src
                - env:
                    - QTDIR: "/usr/share/qt3"
                    - QTMAKESPEC: "/usr/share/qt3/mkspecs/linux-g++"
                - name: /tmp/{{ vec2web_version }}.src/build_vec2web.sh

        source_install vec2web file install - /usr/bin/vec2web:
            file.managed:
                - name: /usr/bin/vec2web
                - skip_verify: true
                - source: /tmp/{{ vec2web_version }}.src/vec2web/vec2web
                - user: root
                - group: root
                - mode: 0755

        # clean_vec2web:
        #     file.absent:
        #         - name: /tmp/{{ vec2web_version }}.src

    {% endif %}
{% endif %}
