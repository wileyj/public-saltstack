{% from "logrotate/map.jinja" import logrotate with context %}

logrotate:
  pkg.installed:
    - name: {{ logrotate.pkg|json }}
{% if grains['virtual_subtype'] != 'Docker' %}
  service.running:
    - name: {{ logrotate.service }}
    - enable: True
{% if grains['instance']['build_type'] != 'Packer' %}
    # - reload: True
{% endif %}
{% endif %}

logrotate_directory:
  file.directory:
    - name: {{ logrotate.include_dir }}
    - user: {{ salt['pillar.get']('logrotate:config:user', logrotate.user) }}
    - group: {{ salt['pillar.get']('logrotate:config:group', logrotate.group) }}
    - mode: 755
    - makedirs: True
    - require:
      - pkg: logrotate
