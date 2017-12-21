# harden.services
# psad is being a bitch. disable for now
# harden.psad:
#   service.running:
#     - name: psad
#     - enable: True
#     - restart: True
#     - require:
#       - pkg: harden.packages
#
