/u:
  file.directory:
   - user: root
   - group: root
   - mode: 0755

/u/log:
  file.directory:
   - user: root
   - group: root
   - mode: 0755

/u/logs:
  file.symlink:
    - target: /u/log

/opt:
  file.directory:
   - user: root
   - group: root
   - mode: 0755

/opt/scripts:
  file.directory:
   - user: root
   - group: root
   - mode: 0755

/opt/scripts/git_key:
  file.managed:
    - source: salt://base/files/opt/scripts/git_key
    - user: root
    - group: root
    - mode: 0755

/opt/scripts/git_wrapper:
  file.managed:
    - source: salt://base/files/opt/scripts/git_wrapper
    - user: root
    - group: root
    - mode: 0755

/etc/profile:
  file.managed:
    - source: salt://base/files/etc/profile
    - user: root
    - group: root
    - mode: 0644

/etc/motd:
  file.managed:
    - source: salt://base/files/etc/motd
    - user: root
    - group: root
    - mode: 0644

/usr/bin/sleeper:
  file.managed:
    - source: salt://base/files/usr/bin/sleeper
    - user: root
    - group: root
    - mode: 0755

# {% if grains['os'] == 'CentOS' or grains['os'] == 'Amazon' %}
# /etc/profile.d/os-security.sh:
#     file.managed:
#       - user: root
#       - group: root
#       - mode: 0755
#       - contents:
#         - "readonly TMOUT=900"
#         - "readonly HISTFILE"
# {% endif %}
