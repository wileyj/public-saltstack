#bastion.files

# /opt/scripts/chroot_setup.pl:
#   file.managed:
#       - user: root
#       - group: root
#       - mode: 0755
#       - source: salt://bastion/files/opt/scripts/chroot_setup.pl
/export:
  file.directory:
    - owner: root
    - group: root
    - mode: 0755

/export/jail:
  file.directory:
    - owner: root
    - group: root
    - mode: 0755

# this is being added to chroot script. 
# /home/rzshuser/.ssh:
#   file.directory:
#     - owner: rzshuser
#     - group: jailed
#     - mode: 0700
#
# /home/rzshuser/.ssh/authorized_keys:
#   file.touch
