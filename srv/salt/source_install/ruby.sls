# source_install.ruby
{% if pillar['role'] is defined %}
{% set ruby_version = pillar['role']['ruby_version'] | default(None) %}
{% set ruby_version_dl_url = pillar['role']['ruby_version_dl_url'] | default(None) %}
{% endif %}
{% if ruby_version and ruby_version_dl_url %}
    source_install ruby extract - ruby-{{ ruby_version}}:
        archive.extracted:
            - name: /tmp
            - source: {{ ruby_version_dl_url }}
            - archive_format: tar
            - skip_verify: true
            - trim_output: 10
            - if_missing: /tmp/{{ ruby_version }}

    source_install ruby configure - ruby-{{ ruby_version }}:
        cmd.run:
            - cwd: /tmp/{{ ruby_version }}
            - name: ./configure

    source_install ruby make - ruby-{{ ruby_version }}:
        cmd.run:
            - cwd: /tmp/{{ ruby_version }}
            - name: make

    source_install ruby install - ruby-{{ ruby_version }}:
        cmd.run:
            - cwd: /tmp/{{ ruby_version }}
            - name:  make install

    source_install ruby dir delete - /tmp{{ ruby_version }}:
        file.absent:
            - name: /tmp/{{ ruby_version }}

{% endif %}
