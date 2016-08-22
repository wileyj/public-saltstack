audit-pam-su:
  file.append:
    - name: /etc/pam.d/su
    - source: salt://audit/files/audit.pam
