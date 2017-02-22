harden kernel - /etc/modprobe.d/dccp.conf:
    file.managed:
        - name: /etc/modprobe.d/dccp.conf
        - user: root
        - group: root
        - contents_pillar: "kernel_modules:tipc"

harden kernel - /etc/modprobe.d/tipc.conf:
    file.managed:
        - name: /etc/modprobe.d/tipc.conf
        - user: root
        - group: root
        - contents_pillar: 'kernel_modules:tipc'

harden kernel - /etc/modprobe.d/sctp.conf:
    file.managed:
        - name: /etc/modprobe.d/tipc.conf
        - user: root
        - group: root
        - contents_pillar: 'kernel_modules:sctp'

harden kernel - /etc/modprobe.d/rds.conf:
    file.managed:
        - name: /etc/modprobe.d/rds.conf
        - user: root
        - group: root
        - contents_pillar: 'kernel_modules:rds'
