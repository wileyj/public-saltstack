# topfile
{% set os_family = grains['os_family']       | default(None)  %}
{% set environment = grains['environment'] | default(None) %}
{% set application = grains['application'] | default(None) %}
{% set virt = grains['virtual_subtype'] | default(None)  %}

{% if environment and environment == 'prod' %}
    {% set file_root = "/srv/salt" %}
{% elif environment and environment == "staging" %}
    {% set file_root = "/srv/salt" %}
{% elif environment and environment == "dev" %}
    {% set file_root = "/srv/salt" %}
{% else %}
    {% set file_root = "/srv/salt" %}
{% endif %}
file_roots:
  dev:
    - {{ file_root }}
  qa:
    - {{ file_root }}
  prod:
    - {{ file_root }}

base:
  '*':
    - limits
    - resolver
    - repo
{% if virt != 'Docker' %}
    - ssh
    - sysctl
{% endif %}
    - base

# this is where we run formulas for any role assigned to the host (retrieved by name)
# - roles

{% if salt['grains.get']('role', False)  and salt['grains.get']('role') != 'base' %}
{% set role = grains['role'] | default(None) %}
{% set role_sls = '{0}/{1}/init.sls'.format(file_root, role) -%}
{% if salt['file.file_exists'](role_sls) %}
  'role:{{ role }}':
    - match: grain
    - ignore_missing: True
    - {{ role }}
{% endif %}
{% endif %}
    - sudoers
{% if virt != 'Docker' %}
    - denyhosts
    - sensu
    - harden
{% endif %}

# # this should always be run last
# {% if salt['grains.get']('instance:cleanup', False)  %}
#     - cleanup
# {% endif %}
