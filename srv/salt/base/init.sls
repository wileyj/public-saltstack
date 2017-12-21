# base.init
include:
    # - resolver
    # - repo
    # - ssh
    # - limits
    # - denyhosts
    # - sudoers
    # - sysctl
    - base.packages
    - base.modules
    - base.files
    - base.templates
{% if grains['virtual_subtype'] != 'Docker' %}
    - base.services
    - base.ntp
    - base.users
    - logrotate.jobs
{% endif %}
