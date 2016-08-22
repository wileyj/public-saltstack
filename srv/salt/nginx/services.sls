nginx:
  service.running:
    - require:
      - pkg: nginx.packages
    - watch:
      - file: /etc/nginx/nginx.conf
