# cleanup.init
{% if grains["virtual_subtype"]  == "Xen PV DomU" %}
{% set virt = "EC2" %}
{% else %}
{% set virt = grains['virtual_subtype'] | default(None)  %}
{% endif %}

include:
  - cleanup.{{ virt }}
