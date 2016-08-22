{% from 'audit/map.jinja' import audit with context %}

auditd-pkg:
  pkg.installed:
    - name: {{ audit.pkg }}

auditd-sysconfig:
  file.managed:
    - name: {{ audit.config }}
    - source: salt://audit/files/auditd.sysconfig
    - template: jinja
    - mode: 0640

auditd-conf:
  file.managed:
    - name: /etc/audit/auditd.conf
    - source: salt://audit/files/auditd.conf
    - template: jinja
    - mode: 0640

auditd-rules:
  file.managed:
    - name: /etc/audit/audit.rules
    - source: salt://audit/files/audit.rules
    - template: jinja
    - mode: 0640

audispd-conf:
  file.managed:
    - name: /etc/audisp/audispd.conf
    - source: salt://audit/files/audispd.conf
    - template: jinja
    - mode: 0640
