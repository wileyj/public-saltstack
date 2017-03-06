# base.files
# create
base files - /u:
    file.directory:
        - name: /u
        - owner: root
        - group: root
        - mode: 0755

base files - /u/log:
    file.directory:
        - name: /u
        - owner: root
        - group: root
        - mode: 0755

base files - /opt:
    file.directory:
        - name: /u
        - owner: root
        - group: root
        - mode: 0755

base files - /opt/scripts:
    file.directory:
        - name: /u
        - owner: root
        - group: root
        - mode: 0755

base files - /etc/service:
    file.directory:
        - name: /u
        - owner: root
        - group: root
        - mode: 0755

#symlink
base files - /u/logs:
    file.symlink:
        - name: /u/log
        - target: /u/logs
