# base.resolver
resolver:
    nameservers:
{% if grains['virtual_subtype'] == 'Docker' %}
        - 192.168.65.1
{% endif %}
        - 8.8.8.8
        - 8.8.4.4
    # searchpaths:
    #   - moil.io
    #   - wileyj.net
    options:
        - rotate
        - timeout:1
