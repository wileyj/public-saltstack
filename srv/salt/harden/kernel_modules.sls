/etc/modprobe.d/dccp.conf:
  file.managed:
    - user: root
    - group: root
    - contents_pillar: "kernel_modules:tipc"

/etc/modprobe.d/tipc.conf:
  file.managed:
    - user: root
    - group: root
    - contents_pillar: 'kernel_modules:tipc'

/etc/modprobe.d/sctp.conf:
  file.managed:
    - user: root
    - group: root
    - contents_pillar: 'kernel_modules:sctp'

/etc/modprobe.d/rds.conf:
  file.managed:
    - user: root
    - group: root
    - contents_pillar: 'kernel_modules:rds'
