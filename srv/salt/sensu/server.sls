#sensu.server
# /etc/init.d/sensu-api:
#   file.managed:
#     - user: root
#     - group: root
#     - mode: 0755
#     - source: salt://base/files/etc/init.d/sensu-api
#
# /etc/init.d/sensu-server:
#   file.managed:
#     - user: root
#     - group: root
#     - mode: 0755
#     - source: salt://base/files/etc/init.d/sensu-server
#
# /etc/init.d/sensu-service:
#   file.managed:
#     - user: root
#     - group: root
#     - mode: 0755
#     - source: salt://base/files/etc/init.d/sensu-service

/etc/sensu/config.json:
  file.managed:
    - owner: sensu
    - group: sensu
    - mode: 0644
    - template: jinja
    - source: salt://sensu/templates/configs/config.json.jinja

server-/etc/sensu/conf.d/communication/mailer.json:
  file.managed:
    - name: /etc/sensu/conf.d/communication/mailer.json
    - owner: sensu
    - group: sensu
    - mode: 0644
    - template: jinja
    - source: salt://sensu/templates/communication/mailer.json.jinja
