openssh-server:
  pkg.installed

/etc/ssh/sshd_config:
  file.managed:
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - source: salt://ssh/templates/sshd_config.jinja
    - require:
      - pkg: openssh-server

sshd:
  service.running:
    - require:
      - pkg: openssh-server
      - file: /etc/ssh/sshd_config

{% if grains['role'] == "bastion" %}
/etc/ssh/authorized_keys:
  file.directory:
    - owner: root
    - group: root
    - mode: 0755
    - file_mode: 644
    - recurse:
      - user
      - group
{% endif %}
