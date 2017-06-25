include:
  - ssh

openssh-server:
  pkg.installed

sshd:
  service.running:
    - require:
      - pkg: openssh-clients
      - pkg: openssh-server
      - file: /etc/ssh/sshd_config.new

/etc/ssh/sshd_config.new:
  file.managed:
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - source: salt://ssh/templates/sshd_config.j2
    - require:
      - pkg: openssh-server
