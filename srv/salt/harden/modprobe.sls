harden modprobe - /etc/modprobe.d/cramfs.conf:
    file.managed:
        - name: /etc/modprobe.d/cramfs.conf
        - user: root
        - group: root
        - mode: 0644
        - contents:
            - "install cramfs /bin/false"

harden modprobe - /etc/modprobe.d/freevxfs.conf:
    file.managed:
        - name: /etc/modprobe.d/freevxfs.conf
        - user: root
        - group: root
        - mode: 0644
        - contents:
            - "install freevxfs /bin/false"

harden modprobe - /etc/modprobe.d/jffs2.conf:
    file.managed:
        - name: /etc/modprobe.d/jffs2.conf
        - user: root
        - group: root
        - mode: 0644
        - contents:
            - "install jffs2 /bin/false"

harden modprobe - /etc/modprobe.d/hfs.conf:
    file.managed:
        - name: /etc/modprobe.d/hfs.conf
        - user: root
        - group: root
        - mode: 0644
        - contents:
            - "install hfs /bin/false"

harden modprobe - /etc/modprobe.d/hfsplus.conf:
    file.managed:
        - name: /etc/modprobe.d/hfsplus.conf
        - user: root
        - group: root
        - mode: 0644
        - contents:
            - "install hfsplus /bin/false"

harden modprobe - /etc/modprobe.d/squashfs.conf:
    file.managed:
        - name: /etc/modprobe.d/squashfs.conf
        - user: root
        - group: root
        - mode: 0644
        - contents:
            - "install squashfs /bin/false"

harden modprobe - /etc/modprobe.d/udf.conf:
    file.managed:
        - name: /etc/modprobe.d/udf.conf
        - user: root
        - group: root
        - mode: 0644
        - contents:
            - "install udf /bin/false"
