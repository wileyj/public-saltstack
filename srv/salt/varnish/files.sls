# varnish.files
varnish dir - /etc/varnish/vcl.d:
    file.recurse:
        - name: /etc/varnish/vcl.d
        - user: root
        - group: root
        - makedirs: True
        - file_mode: 0644
        - dir_mode: 0755
        - recurse:
            - user
            - group
            - mode
        - source: salt://varnish/files/etc/varnish/vcl.d

varnish file - /etc/varnish/secrets:
    file.managed:
        - name: /etc/varnish/secrets
        - user: root
        - group: root
        - file_mode: 0600
        - source: salt://varnish/templates/secret.jinja
        - template: jinja

varnish file - /etc/varnish/varnish.params:
    file.managed:
        - name: /etc/varnish/varnish.params
        - user: root
        - group: root
        - file_mode: 0644
        - source: salt://varnish/files/etc/varnish/varnish.params

varnish file - /etc/varnish/default.vcl:
    file.managed:
        - name: /etc/varnish/default.vcl
        - user: root
        - group: root
        - file_mode: 0644
        - source: salt://varnish/files/etc/varnish/default.vcl
