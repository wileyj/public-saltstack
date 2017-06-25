{% if grains['os_family'] == 'Debian' and salt['pkg.version']('resolvconf') %}
{% set is_resolvconf_enabled = true %}
{% else %}
{% set is_resolvconf_enabled = false %}
{% endif %}


include:
    - resolver.files
# {% if is_resolvconf_enabled and grains['virtual_subtype'] != 'Docker' %}
#     - resolver.cmd
# {% endif %}
