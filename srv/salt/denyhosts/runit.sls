# denyhosts.runit
denyhosts runit dir:
    file.directory:
        - name: /etc/service/denyhosts
        - user: root
        - group: root
        - mode: 0755
        - makedirs: True

denyhosts runit script:
    file.managed:
        - name: /etc/service/denyhosts/run
        - user: root
        - group: root
        - mode: 0755
        - source: salt://runit/files/etc/service/denyhosts/run
