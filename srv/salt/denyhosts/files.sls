/opt/denyhosts/etc/denyhosts.cfg:
  file.managed:
    - user: root
    - group: root
    - mode: 0644
    - template: jinja
    - source: salt://denyhosts/templates/denyhosts.cfg.j2

/opt/denyhosts/bin/denyhosts.py:
  file.managed:
    - user: root
    - group: root
    - mode: 0755
    - source: salt://denyhosts/files/opt/denyhosts/bin/denyhosts.py

/etc/init.d/denyhosts:
  file.managed:
    - user: root
    - group: root
    - mode: 0755
    - source: salt://denyhosts/files/etc/init.d/denyhosts
