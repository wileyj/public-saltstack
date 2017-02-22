# varnish:init
include:
    - varnish.files
{% if grains['virtual_subtype'] == 'Docker' %}
    - varnish.runit
{% endif %}


#
# https://github.com/jnerin/varnish-4-aws-ec2-autoscalinggroup
# https://github.com/tazjin/varnish-elb-systemd
