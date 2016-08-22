python.modules:
  pip.installed:
    - pkgs: {{ pillar['python']['modules'] }}
    - upgrade: True
    - ignore_installed: True
