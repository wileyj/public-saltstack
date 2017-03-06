# harden.firewall
# don't use this for now
include:
  - harden.packages
  - harden.services

{% for key,rule in salt['pillar.get']('user-ports',{}).items() %}

user-ports-{{key}}:

  iptables.append:
    - table: filter
    - chain: {{rule.get('chain', 'INPUT')}}
    - jump: ACCEPT
    - match: state
    - connstate: NEW
{% if rule.get('source') %}
    - source: {{rule.get('source')}}
{% endif %}
    - dport: {{rule.get('dport')}}
    - proto: {{rule.get('proto', 'tcp')}}
    - sport: 1025:65535
    - save: True
{% endfor %}

allow established:
  iptables.append:
    - table: filter
    - chain: INPUT
    - match: state
    - connstate: ESTABLISHED
    - jump: ACCEPT
    - save: True

default to drop:
  iptables.set_policy:
    - table: filter
    - chain: INPUT
    - policy: DROP
