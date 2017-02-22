# sumologic:files
sumologic dir - /etc/sumo-sources.json:
    file.recurse:
        - name: /etc/sumo-sources.json
        - user: root
        - group: root
        - makedirs: True
        - file_mode: 0644
        - dir_mode: 0755
        - recurse:
            - user
            - group
            - mode
        - source: salt://sumologic/sumo-sources.json

sumologic exec file - /usr/local/bin/sumologic:
    file.managed:
        - name: /usr/local/bin/sumo_exec
        - user: root
        - group: root
        - file_mode: 0755
        - source: salt://sumologic/files/usr/local/bin/sumologic
