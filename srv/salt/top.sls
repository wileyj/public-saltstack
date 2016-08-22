# https://docs.saltstack.com/en/latest/ref/states/top.html

file_roots:
  dev:
    - /srv/salt
  qa:
    - /srv/salt
  prod:
    - /srv/salt

base:
  '*':
    - base
    - python
    - resolver
    - limits
    - sysctl
    - logrotate.jobs
    - denyhosts
    - harden
  {% set roles = salt['grains.get']('roles',[]) -%}
  {% for role in roles -%}
  {% set states = salt['pillar.get']('states:'+role,[]) -%}
  {% if states -%}
  'roles:{{ role }}':
    - match: grain
    {% for state in states -%}
    - roles.{{ state }}
    {% endfor -%}
  {% endif -%}
  {% endfor -%}
