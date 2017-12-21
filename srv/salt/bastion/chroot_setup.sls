# bastion.chroot
/opt/scripts/chroot_setup.pl:
  file.managed:
      - user: root
      - group: root
      - mode: 0755
      - source: salt://bastion/files/opt/scripts/chroot_setup.pl
  # cmd.run:
  #   - creates:
  #     - /etc/sysconfig/chroot_setup
  #   - unless:
  #     - test -f /etc/sysconfig/chroot_setup


/opt/scripts/chroot_setup.py:
  file.managed:
      - user: root
      - group: root
      - mode: 0755
      - source: salt://bastion/files/opt/scripts/chroot_setup.py
  cmd.run:
    - creates:
      - /etc/sysconfig/chroot_setup
    - unless:
      - test -f /etc/sysconfig/chroot_setup

# after chroot_setup runs, we need to copy over passwd/group files for uid stuffs
/export/jail/etc/passwd:
  file.copy:
    - name: /export/jail/etc/passwd
    - source: /etc/passwd
    - preserve: True
    - force: True

/export/jail/etc/group:
  file.copy:
    - name: /export/jail/etc/group
    - source: /etc/group
    - preserve: True
    - force: True
