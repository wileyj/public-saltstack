# repo.redhat.init
include:
    - repo.{{ grains['os_family'] }}.epel
    - repo.{{ grains['os_family'] }}.erlang
    - repo.{{ grains['os_family'] }}.moil
