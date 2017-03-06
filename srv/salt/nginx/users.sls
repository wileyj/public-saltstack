# nginx.users
nginx user creation:
  user.present:
    - fullname: Nginx
    - home: /etc/nginx
    - shell: /sbin/nologin
    - uid: 495
    - gid: 495

nginx group creation:
  group.present:
    - gid: 495
    - system: True
    - members:
      - nginx
