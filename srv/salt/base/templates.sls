# base.files
/etc/environment:
  file.managed:
    - owner: root
    - group: root
    - mode: 0644
    - template: jinja
    - source: salt://base/templates/environment.jinja

/etc/hostname:
  file.managed:
    - owner: root
    - group: root
    - mode: 0644
    - template: jinja
    - source: salt://base/templates/hostname.jinja

/etc/hosts:
  file.managed:
    - owner: root
    - group: root
    - mode: 0644
    - template: jinja
    - source: salt://base/templates/hosts.jinja

/etc/profile:
  file.managed:
    - owner: root
    - group: root
    - mode: 0755
    - template: jinja
    - source: salt://base/templates/profile.jinja
