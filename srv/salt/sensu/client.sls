# sensu.client
/etc/init.d/sensu-client:
  file.managed:
    - name: /etc/init.d/sensu-client
    - user: root
    - group: root
    - mode: 0755
    - source: salt://sensu/files/etc/init.d/sensu-client

/etc/default/sensu:
  file.managed:
    - user: sensu
    - group: sensu
    - mode: 0644
    - source: salt://sensu/files/etc/default/sensu

/etc/sensu:
  file.directory:
    - owner: sensu
    - group: sensu
    - mode: 0755

/etc/sensu/ssl:
  file.directory:
    - owner: sensu
    - group: sensu
    - mode: 0755

/etc/sensu/conf.d:
  file.directory:
    - owner: sensu
    - group: sensu
    - mode: 0755


/etc/sensu/conf.d/communication:
  file.directory:
    - owner: sensu
    - group: sensu
    - mode: 0755

/etc/sensu/conf.d/services:
  file.directory:
    - owner: sensu
    - group: sensu
    - mode: 0755

/etc/sensu/conf.d/checks:
  file.recurse:
    - source: salt://sensu/files/etc/sensu/conf.d/checks
    - include_empty: True
    - owner: sensu
    - group: sensu
    - file_mode: 0644
    - dir_mode: 0755

/etc/sensu/plugins:
  file.recurse:
    - source: salt://sensu/files/etc/sensu/plugins
    - include_empty: True
    - owner: sensu
    - group: sensu
    - file_mode: 0755
    - dir_mode: 0755

/etc/sensu/handlers:
  file.recurse:
    - source: salt://sensu/files/etc/sensu/handlers
    - include_empty: True
    - owner: sensu
    - group: sensu
    - file_mode: 0755
    - dir_mode: 0755

/etc/sensu/metrics:
  file.recurse:
    - source: salt://sensu/files/etc/sensu/metrics
    - include_empty: True
    - owner: sensu
    - group: sensu
    - file_mode: 0755
    - dir_mode: 0755

/etc/sensu/mutators:
  file.recurse:
    - source: salt://sensu/files/etc/sensu/mutators
    - include_empty: True
    - owner: sensu
    - group: sensu
    - file_mode: 0755
    - dir_mode: 0755

/etc/sensu/extensions:
  file.recurse:
    - source: salt://sensu/files/etc/sensu/extensions
    - include_empty: True
    - owner: sensu
    - group: sensu
    - file_mode: 0755
    - dir_mode: 0755

/etc/sensu/conf.d/client.json:
  file.managed:
    - owner: sensu
    - group: sensu
    - mode: 0644
    - template: jinja
    - source: salt://sensu/templates/configs/client.json.jinja

/etc/sensu/conf.d/services/api.json:
  file.managed:
    - owner: sensu
    - group: sensu
    - mode: 0644
    - template: jinja
    - source: salt://sensu/templates/configs/api.json.jinja

/etc/sensu/conf.d/services/redis.json:
  file.managed:
    - owner: sensu
    - group: sensu
    - mode: 0644
    - template: jinja
    - source: salt://sensu/templates/configs/redis.json.jinja

/etc/sensu/conf.d/services/rabbitmq.json:
  file.managed:
    - owner: sensu
    - group: sensu
    - mode: 0644
    - template: jinja
    - source: salt://sensu/templates/configs/rabbitmq.json.jinja

/etc/sensu/conf.d/relay.json:
  file.managed:
    - owner: sensu
    - group: sensu
    - mode: 0644
    - template: jinja
    - source: salt://sensu/templates/configs/relay.json.jinja

client-/etc/sensu/conf.d/communication/mailer.json:
  file.managed:
    - name: /etc/sensu/conf.d/communication/mailer.json
    - owner: sensu
    - group: sensu
    - mode: 0644
    - template: jinja
    - source: salt://sensu/templates/communication/mailer.json.jinja

/etc/sensu/conf.d/handlers/default.json:
  file.managed:
    - owner: sensu
    - group: sensu
    - mode: 0644
    - template: jinja
    - source: salt://sensu/templates/handlers/default.json.jinja

/etc/sensu/conf.d/handlers/file.json:
  file.managed:
    - owner: sensu
    - group: sensu
    - mode: 0644
    - template: jinja
    - source: salt://sensu/templates/handlers/file.json.jinja

/etc/sensu/conf.d/handlers/graphite.json:
  file.managed:
    - owner: sensu
    - group: sensu
    - mode: 0644
    - template: jinja
    - source: salt://sensu/templates/handlers/graphite.json.jinja

/etc/sensu/conf.d/handlers/graphite_line_tcp.json:
  file.managed:
    - owner: sensu
    - group: sensu
    - mode: 0644
    - template: jinja
    - source: salt://sensu/templates/handlers/graphite_line_tcp.json.jinja

/etc/sensu/conf.d/services/relay.json:
  file.absent:
    - name: /etc/sensu/conf.d/services/relay.json

/etc/sensu/conf.d/services/config_relay.json:
  file.absent:
    - name: /etc/sensu/conf.d/services/config_relay.json
