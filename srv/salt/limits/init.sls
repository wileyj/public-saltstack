{% from "limits/templates/package_map.j2" import pkgs with context %}

pam:
  pkg.installed:
    - name: {{ pkgs.pam }}

/etc/security/limits.conf:
  file.managed:
    - user: root
    - group: root
    - mode: 440
    - template: jinja
    - source: salt://limits/templates/limits.j2
    - require:
      - pkg: pam

