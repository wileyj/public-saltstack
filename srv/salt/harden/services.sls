include:
 - denyhosts

harden iptables:
  service.running:
    - enable: True

harden service - psad:
  service.running:
    - enable: True
    - require:
      - watch:
        - file: /etc/psad/psad.conf

harden service - fail2ban:
  service.running:
    - enable: True
    - require:
      - watch:
        - file: /etc/fail2ban/fail2ban.conf

harden service - denyhosts:
  service.running:
    - enable: True
    - require:
      - watch:
        - file: /etc/denyhosts/denyhosts.conf
