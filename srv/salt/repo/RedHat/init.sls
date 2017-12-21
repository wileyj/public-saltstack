# repo.redhat.init
{% set virt = grains['virtual_subtype'] | default(None)  %}

include:
    - repo.{{ grains['os_family'] }}.epel
    - repo.{{ grains['os_family'] }}.postgres
    - repo.{{ grains['os_family'] }}.moil

# remove the temp file we created from packer, if it exists
{% if virt == 'Docker' %}
remove-packer-tempfile:
  file.absent:
    - name: /etc/yum.repos.d/temp.repo
{% endif %}
