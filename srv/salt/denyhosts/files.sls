# denyhosts.files
/opt/denyhosts/bin/denyhosts.py:
  file.managed:
    - name: /opt/denyhosts/bin/denyhosts.py
    - user: root
    - group: root
    - mode: 0755
    - source: salt://denyhosts/files/opt/denyhosts/bin/denyhosts.py

/opt/denyhosts/bin/reset-blocked.py:
  file.managed:
    - name: /opt/denyhosts/bin/reset-blocked.py
    - user: root
    - group: root
    - mode: 0755
    - source: salt://denyhosts/files/opt/denyhosts/bin/reset-blocked.py

/etc/init.d/denyhosts:
  file.managed:
    - name: /etc/init.d/denyhosts
    - user: root
    - group: root
    - mode: 0755
    - source: salt://denyhosts/files/etc/init.d/denyhosts

/opt/denyhosts/data/allowed-hosts:
  file.managed:
    - name: /opt/denyhosts/data/allowed-hosts
    - user: root
    - group: root
    - mode: 0644
    - source: salt://denyhosts/files/opt/denyhosts/data/allowed-hosts

/opt/denyhosts/bin/denyhosts_ctl:
  file.managed:
    - name: /opt/denyhosts/bin/denyhosts_ctl
    - user: root
    - group: root
    - mode: 0755
    - source: salt://denyhosts/files/opt/denyhosts/bin/denyhosts_ctl
