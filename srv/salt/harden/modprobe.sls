/etc/modprobe.d/cramfs.conf:
  file.managed:
    - user: root
    - group: root
    - mode: 0644
    - contents:
      - "install cramfs /bin/false"

/etc/modprobe.d/freevxfs.conf:
  file.managed:
    - user: root
    - group: root
    - mode: 0644
    - contents:
      - "install freevxfs /bin/false"

/etc/modprobe.d/jffs2.conf:
  file.managed:
    - user: root
    - group: root
    - mode: 0644
    - contents:
      - "install jffs2 /bin/false"

/etc/modprobe.d/hfs.conf:
  file.managed:
    - user: root
    - group: root
    - mode: 0644
    - contents:
      - "install hfs /bin/false"

/etc/modprobe.d/hfsplus.conf:
  file.managed:
    - user: root
    - group: root
    - mode: 0644
    - contents:
      - "install hfsplus /bin/false"

/etc/modprobe.d/squashfs.conf:
  file.managed:
    - user: root
    - group: root
    - mode: 0644
    - contents:
      - "install squashfs /bin/false"

/etc/modprobe.d/udf.conf:
  file.managed:
    - user: root
    - group: root
    - mode: 0644
    - contents:
      - "install udf /bin/false"
