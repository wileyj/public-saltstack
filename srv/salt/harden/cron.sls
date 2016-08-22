include:
  - harden.packages

/etc/cron.daily/00logwatch.cron:
  file:
    - managed
    - template: jinja
    - source: salt://harden/files/etc/cron.daily/00logwatch.cron
    - require:
      - pkg: harden.packages

/etc/cron.daily/aide.cron:
  file:
    - managed
    - template: jinja
    - source: salt://harden/files/etc/cron.daily/aide.cron
    - require:
      - pkg: harden.packages

/etc/cron.daily/chkrootkit.cron:
  file:
    - managed
    - template: jinja
    - source: salt://harden/files/etc/cron.daily/chkrootkit.cron
    - require:
      - pkg: harden.packages

