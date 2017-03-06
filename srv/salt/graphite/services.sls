# grapite.services
graphite services:
    service.running:
        - enable: True
        - reload: True
        - require:
            - pkg: pgraphite
            # - watch:
            #     - file: /opt/denyhosts/etc/denyhosts.cfg
