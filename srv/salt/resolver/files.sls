# resolver.files

resolv-file:
    file.managed:
        - name: /etc/resolv.conf
        - user: root
        - group: root
        - mode: '0644'
        - source: salt://resolver/templates/resolv.conf.jinja
        - template: jinja
