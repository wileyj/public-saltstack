i/dev/mapper/lg_os-lv_root /                       xfs     defaults        1 1
UUID=d73c5d22-75ed-416e-aad2-8c1bb1dfc713 /boot                   ext4    defaults,nosuid,noexec,nodev        1 2
/dev/mapper/lg_data-lv_home /home                   xfs     defaults        1 2
/dev/mapper/lg_os-lv_tmp /tmp                    xfs     defaults,nosuid,noexec,nodev        1 2
/dev/mapper/lg_os-lv_var /var                    xfs     defaults,nosuid        1 2
/dev/mapper/lg_os-lv_var_tmp /var/tmp                xfs     defaults,nosuid,noexec,nodev        1 2
/dev/mapper/lg_os-lv_var_tmp /var/log                xfs     defaults,nosuid,noexec,nodev        1 2
/dev/mapper/lg_os-lv_var_tmp /var/log/audit                xfs     defaults,nosuid,noexec,nodev        1 2
/dev/mapper/lg_data-lv_var_www /var/www                xfs     defaults,nosuid,noexec,nodev        1 2
/dev/mapper/lg_data-lv_swap swap                    swap    defaults        0 0

echo "install cramfs /bin/false" > /etc/modprobe.d/cramfs.conf
echo "install freevxfs /bin/false" > /etc/modprobe.d/freevxfs.conf
echo "install jffs2 /bin/false" > /etc/modprobe.d/jffs2.conf
echo "install hfs /bin/false" > /etc/modprobe.d/hfs.conf
echo "install hfsplus /bin/false" > /etc/modprobe.d/hfsplus.conf
echo "install squashfs /bin/false" > /etc/modprobe.d/squashfs.conf
echo "install udf /bin/false" > /etc/modprobe.d/udf.conf
