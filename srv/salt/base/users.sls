# base.users
# sensu:
#   user.present:
#     - fullname: Sensu
#     - home: /etc/sensu
#     - shell: /sbin/nologin
#     - uid: 419
#     - gid: 419
#
# nginx:
#   user.present:
#     - fullname: Nginx
#     - home: /etc/nginx
#     - shell: /sbin/nologin
#     - uid: 495
#     - gid: 495
#
# nginx:
#   group.present:
#     - gid: 495
#     - system: True
#     - members:
#       - nginx
# jenkins:
#   user.present:
#     - fullname: Jenkins
#     - home: /opt/jenkins/home
#     - shell: /bin/bash
#     - uid: 9
#     - gid: 13
#
# celery-user:
#   user.present:
#     - fullname: Celery
#     - home: /opt/celery
#     - shell: /bin/bash
#     - uid: 502
#     - gid: 502
