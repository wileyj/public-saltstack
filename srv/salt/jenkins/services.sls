# jenkins.services
jenkins services:
    service.running:
        - enable: True
        - reload: True
        - require:
            - pkg: jenkins
            # - watch:
            #     - file: /opt/denyhosts/etc/denyhosts.cfg
