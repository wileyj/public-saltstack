denyhosts:
  service.running:
    - enable: True
    - reload: True
    - require:
      - pkg: denyhosts
      - watch:
        - file: /opt/denyhosts/etc/denyhosts.cfg
