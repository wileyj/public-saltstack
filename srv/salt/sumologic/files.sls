# sumologic.files
{% set sumo_user = pillar['role']['user'] | default('sumologic_collector') %}
{% set sumo_group = pillar['role']['group'] | default('sumologic_collector') %}
sumologic dir - /etc/sumo.d:
    file.recurse:
        - name: /etc/sumo.d
        - user: {{ sumo_user }}
        - group: {{ sumo_group }}
        - makedirs: True
        - file_mode: 0644
        - dir_mode: 0755
        - recurse:
            - user
            - group
            - mode
        - source: salt://sumologic/files/etc/sumo.d

sumologic exec file - /usr/local/bin/sumologic:
    file.managed:
        - name: /usr/local/bin/sumologic
        - user: root
        - group: root
        - mode: 0755
        - source: salt://sumologic/files/usr/local/bin/sumologic
