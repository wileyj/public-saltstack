{% set is_resolvconf_enabled = grains['os_family'] == 'Debian' and salt['pkg.version']('resolvconf') %}

include:
    - resolver.files
{% if is_resolvconf_enabled and grains['virtual_subtype'] != 'Docker' %}
    - resolver.cmd
{% endif %}
