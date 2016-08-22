include:
 - denyhosts

iptables:
  service.running:
    - enable: True

psad:
  service.running:
    - enable: True
    - require:
      - watch:
        - file: /etc/psad/psad.conf

fail2ban:
  service.running:
    - enable: True
    - require:
      - watch:
        - file: /etc/fail2ban/fail2ban.conf
