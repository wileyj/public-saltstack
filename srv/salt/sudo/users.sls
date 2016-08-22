cloud-init:
    priority : 2
    sudo_config_dir:  /etc/sudoers.d/
    content  : "# File Maintained by puppet. Do Not Edit Manually\nec2-user ALL=(ALL) NOPASSWD:ALL"
