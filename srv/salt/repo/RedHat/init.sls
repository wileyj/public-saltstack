# repo:redhat:init
include:
    - repo.{{ grains['osfamily'] }}.epel
    - repo.{{ grains['osfamily'] }}.erlang
    - repo.{{ grains['osfamily'] }}.local
