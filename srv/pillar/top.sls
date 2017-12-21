# topfile
{% set os = grains['os'] | default(None)  %}
{% set os_family = grains['os_family'] | default(None)  %}
{% set osfullname = grains['osfullname']| default(None)  %}
{% set virt = grains['virtual_subtype'] | default(None)  %}
{% set application = grains['application'] | default(None)  %}
{% set role = grains['role'] | default(None)  %}
{% set environment = grains['environment']| default(None)  %}
{% set profile = grains['profile']| default(None)  %}
base:
  '*':
    - base/resolver
    - base/base
    - base/harden
    - base/limits
    - base/packages
    - base/services
    - base/modules
    - base/sysctl
    - base/logrotate
    - base/denyhosts
    - private/base
    - private/resolver
    - private/ssh
    - base/ntp
    - users/base
  {% if virt != 'Docker' %}
    - users/sensu
    - base/sensu
    # - base/statsd
    - private/sensu
    - private/users/base
  {% endif %}
    - base/sudo

# OS
  "os:{{ os }}":
    - match: grain
    - ignore_missing: True
    - os/{{ os_family }}
    - os/{{ os_family }}/{{ os }}
    - os/files

# environment
{% if environment %}
  "environment:{{ environment }}":
    - match: grain
    - ignore_missing: True
    - environment/{{ environment }}
{% endif %}

# role
{% if role %}
  "role:{{ role }}":
    - match: grain
    - ignore_missing: True
    - users/{{ role }}
    - role/{{ role }}
    - private/role/{{ role }}
    - private/users/{{ role }}
{% endif %}

# match a role of rabbitmq and a profile of sensu to build the rabbitmq sensu server
  'G@role:rabbitmq and G@profile:sensu':
    - match: compound
    - ignore_missing: True
    - role/sensu/rabbitmq
    - private/role/sensu/rabbitmq

# match a role of redis and a profile of sensu to build the redis sensu server
  'G@role:redis and G@profile:sensu':
    - match: compound
    - ignore_missing: True
    - role/sensu/redis
    - private/role/sensu/redis
