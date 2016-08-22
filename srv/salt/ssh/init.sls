openssh-clients:
  pkg.installed

/etc/ssh/ssh_config.new:
  file:
    - managed
    - user: root
    - group: root
    - mode: 644
    - source: salt://ssh/files/etc/ssh/ssh_config
    - require:
      - pkg: openssh-clients
