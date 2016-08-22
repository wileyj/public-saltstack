audit-pam-ssh:
  file.append:
    - name: /etc/pam.d/sshd
    - source: salt://audit/files/audit.pam
