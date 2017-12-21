# base.harden
packages:
  harden:
    # - psad
    - aide
    # - logwatch
    - chkrootkit
  # https://www.cyberciti.biz/faq/debian-ubuntu-linux-software-integrity-checking-with-aide/
logwatch:
  mailto: root@localhost
kernel_modules:
  dccp: /bin/true
  tipc: /bin/true
  sctp: /bin/true
  rds: /bin/true
  usb-storage: /bin/true # Disable mounting of USB Mass Storage
  cramfs: /bin/false # Disable mounting of cramfs CCE-14089-7
  freevxfs: /bin/false # Disable mounting of freevxfs CCE-14457-6
  hfs: /bin/false # Disable mounting of hfs CCE-15087-0
  hfsplus: /bin/false # Disable mounting of hfsplus CCE-14093-9
  jffs2: /bin/false # Disable mounting of jffs2 CCE-14853-6
  squashfs: /bin/false # Disable mounting of squashfs CCE-14118-4
  udf: /bin/false # Disable mounting of udf

iptables:
  ssh:
    chain: INPUT
    proto: tcp
    dport: 22
  salt-master:
    chain: INPUT
    proto: tcp
    dport: 4505
  salt-minion:
    chain: INPUT
    proto: tcp
    dport: 4506
