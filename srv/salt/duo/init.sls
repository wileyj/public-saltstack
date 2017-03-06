# duo.init
include:
    - duo.packages

# service:
#   service.running:
#     - enable: True
#     - reload: True
#     - watch:
#       - file: /etc/duo/login_duo.conf
#     - require:
#         -pkg: duo
