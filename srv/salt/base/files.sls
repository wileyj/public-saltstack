# base.files
/u:
  file.directory:
    - owner: root
    - group: root
    - mode: 0755

/u/log:
  file.directory:
    - owner: root
    - group: root
    - mode: 0755

/opt:
  file.directory:
    - owner: root
    - group: root
    - mode: 0755

/opt/scripts:
  file.directory:
    - owner: root
    - group: root
    - mode: 0755

/etc/service:
  file.directory:
    - owner: root
    - group: root
    - mode: 0755

/etc/motd:
  file.managed:
    - owner: root
    - group: root
    - mode: 0644
    - source: salt://base/files/etc/motd


#symlink
/u/logs:
  file.symlink:
    - target: /u/log
