# denyhosts.services
denyhosts_services:
  service.running:
    - name: denyhosts
    - enable: True
    # - reload: True
    - require:
      - pkg: denyhosts_packages
    - watch:
      - file: /opt/denyhosts/etc/denyhosts.conf
