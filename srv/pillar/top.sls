{% set vpc_domain = '.'.join(grains['domain'].lower().split('.')|reverse) %}
{% set vpc_id = grains["ec2-data"]["ec2-info"]["vpc_id"] %}
{% set base_domain = '.'.join(grains['dns']['domain'].lower().split('.')|reverse) %}
{% set domain = grains["dns"]["domain"] %}
{% set region = grains["ec2-metadata"]["region"] %}
{% set rfqdn = '.'.join(grains['fqdn'].lower().split('.')|reverse) %}
{% set prole = grains['fqdn'].lower().split('-')[1] %}
{% set role = grains["ec2-data"]["ec2-tags"]["role"] %}
{% set environment = grains["ec2-data"]["ec2-tags"]["environment"] %}



base:
  '*':
    - common/base
    - common/limits
    - common/packages
    - common/python
    - common/ntp
    - common/denyhosts
    - common/sysctl
    - common/logwatch
    - common/kernel_modules
    - common/uchiwa
    - common/statsd
    - common/sensu
    - common/logrotate
    - sudo/base
    - users/base

# OS of instance
  'os:{{ grains["os"] }}':
    - match: grain
    - ignore_missing: True
    - os/{{ grains["os"] }}

# aws region
  'ec2-metadata:region:{{ region }}':
    - match: grain
    - ignore_missing: True
    - region/{{ region }}

# vpc id
  'ec2-data:ec2-info:vpc_id:{{ vpc_id }}':
    - match: grain
    - ignore_missing: True
    - vpc/{{ vpc_id }}

# Base domain
  'dns:domain:{{ domain }}':
    - match: grain
    - ignore_missing: True
    - domain/{{ base_domain }}

# VPC domain
  'domain:{{ grains["domain"] }}':
    - match: grain
    - ignore_missing: True
    - domain/{{ vpc_domain }}

# role of host
  'ec2-data:ec2-tags:role:{{ role }}':
    - match: grain
    - ignore_missing: True
    - role/{{ prole }}
    - users/{{ prole }}/{{ environment }}
    - sudo/{{ prole }}/{{ environment }}

# environment tag
  'ec2-data:ec2-tags:environment:{{ environment }}':
    - match: grain
    - ignore_missing: True
    - environment/{{ environment }}

# hostname of instance
  'id:{{ grains["id"] }}':
    - match: grain
    - ignore_missing: True
    - hosts/{{ rfqdn }}
    - users/{{ rfqdn }}
    - sudo/{{ rfqdn }}
