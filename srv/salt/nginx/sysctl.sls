# nginx:sysctl
nginx sysctl vm.swappiness:
  sysctl.present:
    - name: vm.swappiness
    - value: 0
