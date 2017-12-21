# base.files
# placeholder for future changes.
# move all file declarations from state to pillar
base:
  files:
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

    /u/logs:
      file.symlink:
        - target: /u/log
