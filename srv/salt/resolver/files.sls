# resolver.files
{% set is_resolvconf_enabled = grains['os_family'] == 'Debian' and salt['pkg.version']('resolvconf') %}
resolv-file:
    file.managed:
        {% if is_resolvconf_enabled and grains['virtual_subtype']  != 'Docker' %}
        - name: /etc/resolvconf/resolv.conf.d/base
        {% else %}
        - name: /etc/resolv.conf
        {% endif %}
        - user: root
        - group: root
        - mode: '0644'
        - source: salt://resolver/templates/resolv.conf.jinja
        - template: jinja
