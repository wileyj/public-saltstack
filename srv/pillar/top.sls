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
        - base/files
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




# {% set vpc_domain = '.'.join(grains['domain'].lower().split('.')|reverse) %}
# {% set vpc_id = grains["ec2-data"]["ec2-info"]["vpc_id"] %}
# {% set base_domain = '.'.join(grains['dns']['domain'].lower().split('.')|reverse) %}
# {% set domain = grains["dns"]["domain"] %}
# {% set region = grains["ec2-metadata"]["region"] %}
# {% set rfqdn = '.'.join(grains['fqdn'].lower().split('.')|reverse) %}
# {% set prole = grains['fqdn'].lower().split('-')[1] %}
# {% set role = grains["ec2-data"]["ec2-tags"]["role"] %}
# {% set environment = grains["ec2-data"]["ec2-tags"]["environment"] %}
#
#
#
# base:
#   '*':
#     - common/base
#     - common/limits
#     - common/packages
#     - common/python
#     - common/ntp
#     - common/denyhosts
#     - common/sysctl
#     - common/logwatch
#     - common/kernel_modules
#     - common/uchiwa
#     - common/statsd
#     - common/sensu
#     - common/logrotate
#     - sudo/base
#     - users/base
#
# # OS of instance
#   'os:{{ grains["os"] }}':
#     - match: grain
#     - ignore_missing: True
#     - os/{{ grains["os"] }}
#
# # aws region
#   'ec2-metadata:region:{{ region }}':
#     - match: grain
#     - ignore_missing: True
#     - region/{{ region }}
#
# # vpc id
#   'ec2-data:ec2-info:vpc_id:{{ vpc_id }}':
#     - match: grain
#     - ignore_missing: True
#     - vpc/{{ vpc_id }}
#
# # Base domain
#   'dns:domain:{{ domain }}':
#     - match: grain
#     - ignore_missing: True
#     - domain/{{ base_domain }}
#
# # VPC domain
#   'domain:{{ grains["domain"] }}':
#     - match: grain
#     - ignore_missing: True
#     - domain/{{ vpc_domain }}
#
# # role of host
#   'ec2-data:ec2-tags:role:{{ role }}':
#     - match: grain
#     - ignore_missing: True
#     - role/{{ prole }}
#     - users/{{ prole }}/{{ environment }}
#     - sudo/{{ prole }}/{{ environment }}
#
# # environment tag
#   'ec2-data:ec2-tags:environment:{{ environment }}':
#     - match: grain
#     - ignore_missing: True
#     - environment/{{ environment }}
#
# # hostname of instance
#   'id:{{ grains["id"] }}':
#     - match: grain
#     - ignore_missing: True
#     - hosts/{{ rfqdn }}
#     - users/{{ rfqdn }}
#     - sudo/{{ rfqdn }}
