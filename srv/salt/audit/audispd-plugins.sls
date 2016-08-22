
audispd-plugins-pkg:
  pkg.installed:
    - name: audispd-plugins

audisp-remote-conf:
  file.managed:
    - name: /etc/audisp/audisp-remote.conf
    - source: salt://audit/files/audisp-remote.conf
    - template: jinja
    - mode: 0640

audisp-zos-remote-conf:
  file.managed:
    - name: /etc/audisp/zos-remote.conf
    - source: salt://audit/files/zos-remote.conf
    - template: jinja
    - mode: 0640

audisp-plugin-af-unix:
  file.managed:
    - name: /etc/audisp/plugins.d/af_unix.conf
    - source: salt://audit/files/plugins.d/af_unix.conf
    - template: jinja
    - mode: 0640

audisp-plugin-au-prelude:
  file.managed:
    - name: /etc/audisp/plugins.d/au-prelude.conf
    - source: salt://audit/files/plugins.d/au-prelude.conf
    - template: jinja
    - mode: 0640

audisp-plugin-au-remote:
  file.managed:
    - name: /etc/audisp/plugins.d/au-remote.conf
    - source: salt://audit/files/plugins.d/au-remote.conf
    - template: jinja
    - mode: 0640

audisp-plugin-zos-remote:
  file.managed:
    - name: /etc/audisp/plugins.d/audispd-zos-remote.conf
    - source: salt://audit/files/plugins.d/audispd-zos-remote.conf
    - template: jinja
    - mode: 0640

audisp-plugin-syslog:
  file.managed:
    - name: /etc/audisp/plugins.d/syslog.conf
    - source: salt://audit/files/plugins.d/syslog.conf
    - template: jinja
    - mode: 0640
