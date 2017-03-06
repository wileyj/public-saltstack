# base.groups
# sensu:
#   group.present:
#     - gid: 419
#     - system: True
#     - members:
#       - sensu
#
# nginx:
#   group.present:
#     - gid: 495
#     - system: True
#     - members:
#       - nginx
#
# celery:
#   group.present:
#     - gid: 502
#     - system: True
#     - members:
#       - celery
#
# dev:
#   group.present:
#     - gid: 1110
#     - system: False
#
# analytics:
#   group.present:
#     - gid: 1210
#     - system: False
#
# admins:
#   group.present:
#     - gid: 1010
#     - system: False
