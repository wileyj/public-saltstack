# jenkins.runit
jenkins runit dir:
    file.directory:
        - name: /etc/service/jenkins
        - user: root
        - group: root
        - mode: 0755
        - makedirs: True

jenkins runit script:
    file.managed:
        - name: /etc/service/jenkins/run
        - user: root
        - group: root
        - mode: 0755
        - source: salt://runit/files/etc/service/jenkins/run
