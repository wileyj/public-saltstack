rabbitmq-server:
  pkg.installed:
    - refresh: True
    - pkgs:
      - erlang
      - rabbitmq-server
  service:
    - {{ "running" if salt['pillar.get']('rabbitmq:running', True) else "dead" }}
    - enable: {{ salt['pillar.get']('rabbitmq:enabled', True) }}
    - name: rabbitmq-server
    - enable: True
    - watch:
      - pkg: rabbitmq-server
