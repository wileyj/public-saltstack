# harden.packages
harden.packages:
  pkg.installed:
    - pkgs: {{ pillar['packages']['harden'] }}
