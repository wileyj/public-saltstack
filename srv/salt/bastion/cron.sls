# bastion.cron
bastion cron - etc/cron.daily/chroot_setup.cron:
    file.managed:
        - name: /etc/cron.daily/chroot_setup.cron
        - source: salt://bastion/files/etc/cron.daily/chroot_setup.cron
        - user: root
        - group: root
        - mode: 644
