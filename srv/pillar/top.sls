# topfile
{% set os = grains['os'] | default(None)  %}
{% set os_family = grains['os_family'] | default(None)  %}
{% set osfullname = grains['osfullname']| default(None)  %}
{% set virt = grains["virtual_subtype"] | default(None)  %}
{% set application = grains['instance']['application'] | default(None)  %}
{% set role = grains['instance']['role'] | default(None)  %}
{% set environment = grains['instance']['environment']| default(None)  %}
base:
    '*':
        - base/resolver
        - base/base
        # - base/files
        - base/limits
        - base/packages
        - base/modules
        - base/sysctl
        - base/logrotate
        - base/ntp
        - users/base
        #- base/statsd
    {% if virt != 'Docker' %}
        - base/sensu
    {% endif %}

    # OS
    "os:{{ os }}":
        - match: grain
        - ignore_missing: True
        - os/{{ os_family }}
        - os/{{ os_family }}/{{ os }}
        - os/files

{% if environment %}
    # environment
    "instance:environment:{{ environment }}":
        - match: grain
        - ignore_missing: True
        - users/environment/{{ environment }}
        - environment/{{ environment }}
{% endif %}

{% if application %}
    # application
    "instance:application:{{ application }}":
        - match: grain
        - ignore_missing: True
        - users/application/{{ application }}
        - application/{{ application }}
{% endif %}

    # role
{% if role %}
    "instance:role:{{ role }}":
        - match: grain
        - ignore_missing: True
        - users/role/{{ application }}/{{ role }}
        - role/{{ application }}/{{ role }}
{% endif %}

    # cleanup
    "virtual_subtype:{{ virt }}":
        - match: grain
        - ignore_missing: True
        - virtual_type/{{ virt}}/{{ os_family }}
        - virtual_type/{{ virt}}/{{ os_family }}/{{ os }}
        - cleanup/{{ virt }}/common
        - cleanup/{{ virt }}/{{ os_family }}
