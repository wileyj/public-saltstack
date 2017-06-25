# limits.init
{% from "limits/templates/package_map.jinja" import pkgs with context %}

pam:
    pkg.installed:
        - name: {{ pkgs.pam }}

{% set limits = pillar.get('limits', {}) | default(None) %}
{% if limits %}
/etc/security/limits.conf:
  file.managed:
    - name: /etc/security/limits.conf
    - source: salt://limits/templates/limits.jinja
    - mode: 440
    - user: root
    - group: root
    - template: jinja
    - require:
      - pkg: pam
{% endif %}
