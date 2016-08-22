python.packages:
  pkg.installed:
    - pkgs: 
      - {{ pillar['packages']['python'] }}
      - {{ pillar['packages']['python-pip'] }}
      - {{ pillar['packages']['python-tools'] }}
      - {{ pillar['packages']['python-setuptools'] }}
      
