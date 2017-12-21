# denyhosts.templates
/opt/denyhosts/etc/denyhosts.conf:
    file.managed:
        - name: /opt/denyhosts/etc/denyhosts.conf
        - user: root
        - group: root
        - mode: 0644
        - template: jinja
        - source: salt://denyhosts/templates/denyhosts.conf.jinja
