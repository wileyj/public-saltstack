#grafana.services
grafana services:
    service.running:
        - enable: True
        - reload: True
        - require:
            - pkg: grafana
            # - watch:
            #     - file: /opt/denyhosts/etc/denyhosts.cfg
