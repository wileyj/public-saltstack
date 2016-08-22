audit-pam-login:
  file.append:
    - name: /etc/pam.d/login
    - source: salt://audit/files/audit.pam
