# denyhosts.files
denyhosts - /opt/denyhosts/etc/denyhosts.cfg:
    file.managed:
        - name: /opt/denyhosts/etc/denyhosts.cfg
        - user: root
        - group: root
        - mode: 0644
        - template: jinja
        - source: salt://denyhosts/templates/denyhosts.cfg.jinja

denyhosts - /opt/denyhosts/bin/denyhosts.py:
    file.managed:
        - name: /opt/denyhosts/bin/denyhosts.py
        - user: root
        - group: root
        - mode: 0755
        - source: salt://denyhosts/files/opt/denyhosts/bin/denyhosts.py

denyhosts - /etc/init.d/denyhosts:
    file.managed:
        - name: /etc/init.d/denyhosts
        - user: root
        - group: root
        - mode: 0755
        - source: salt://denyhosts/files/etc/init.d/denyhosts
