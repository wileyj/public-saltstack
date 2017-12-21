# denyhosts.runit
/etc/service/denyhosts:
    file.directory:
        - name: /etc/service/denyhosts
        - user: root
        - group: root
        - mode: 0755
        - makedirs: True

/etc/service/denyhosts/run:
    file.managed:
        - name: /etc/service/denyhosts/run
        - user: root
        - group: root
        - mode: 0755
        - source: salt://runit/files/etc/service/denyhosts/run
