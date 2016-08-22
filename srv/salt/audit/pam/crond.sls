audit-pam-crond:
  file.append:
    - name: /etc/pam.d/crond
    - source: salt://audit/files/audit.pam
