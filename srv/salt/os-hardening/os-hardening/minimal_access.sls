{% from "os-hardening/map.jinja" import hardening with context %}
hardening-read-only-folders:
  file.directory:
    - names: {{ hardening.read_only_folders }}
    - user: root
    - group: root
    - follow_symlinks: True
    - dir_mode: 755
    - file_mode: 755
    - recurse:
      - user
      - group
      - mode
etc-shadow-file:
  file.managed:
    - name: /etc/shadow
    - user: root
    - group: root
    - mode: 0600
{% if hardening.allow_change_user %}
allow-change-user:
  file.managed:
    - name: /bin/su
    - mode: 0750
{% endif %}
