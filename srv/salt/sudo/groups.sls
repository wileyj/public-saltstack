ui:
  priority : 2
  sudo_config_dir:  /etc/sudoers.d/
  content  : "# File Maintained by puppet. Do Not Edit Manually\n%ui ALL=(ALL) NOPASSWD:DEVCMDS, NETWORKCMDS"

ops:
  priority : 2
  sudo_config_dir:  /etc/sudoers.d/
  content  : "# File Maintained by puppet. Do Not Edit Manually\n%ops ALL=(ALL) NOPASSWD:ALL"

admins:
  priority : 2
  sudo_config_dir:  /etc/sudoers.d/
  content  : "# File Maintained by puppet. Do Not Edit Manually\n%admins ALL=(ALL) NOPASSWD:ALL"

sensu:
  priority : 1
  sudo_config_dir:  /etc/sudoers.d/
  content  : "# File Maintained by puppet. Do Not Edit Manually\nCmnd_Alias SENSU = /usr/sbin/service"

nginx:
  priority : 1
  sudo_config_dir:  /etc/sudoers.d/
  content  : "# File Maintained by puppet. Do Not Edit Manually"

devcmds:
  priority : 1
  sudo_config_dir:  /etc/sudoers.d/
  content  : "# File Maintained by puppet. Do Not Edit Manually\nCmnd_Alias DEVCMDS = /etc/init.d/passenger, /etc/init.d/mysql, /etc/init.d/apache, !/usr/bin/sudo,!/bin/su,!/bin/vi /etc/sudoers,!/usr/sbin/visudo,!/bin/bash,!/bin/csh,!/bin/ksh,!/bin/sh,!/bin/tcsh,!/bin/zsh"

devs:
  priority : 2
  sudo_config_dir:  /etc/sudoers.d/
  content  : "# File Maintained by puppet. Do Not Edit Manually\n%devs ALL=(ALL) NOPASSWD:DEVCMDS, NETWORKCMDS"

admin:
  priority : 2
  sudo_config_dir:  /etc/sudoers.d/
  content  : "# File Maintained by puppet. Do Not Edit Manually\n%admins ALL=(ALL) NOPASSWD:ALL"
