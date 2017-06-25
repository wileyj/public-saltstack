# topfile
{% set virt      = grains['virtual_subtype'] | default(None)  %}
{% set os_family = grains['os_family']       | default(None)  %}
{% set environment = grains['instance']['environment'] | default(None) %}
{% set role = grains['instance']['role'] | default(None) %}
{% set cleanup = grains['instance']['cleanup']| default(None)  %}

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
        - resolver
        - repo
        - base
        - python
        - limits
        - application
{% if virt == 'Docker' and os_family == 'RedHat' %}
        - runit
{% endif %}
{% if virt != 'Docker' %}
        - sysctl
        - logrotate.jobs
        #- harden
{% endif %}
{% if cleanup %}
        - cleanup
{% endif %}
