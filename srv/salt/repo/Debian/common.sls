# repo:debian:common
{% set os_family = grains['os_family'] | default(None) %}
{% set os = grains['os'] | default(None) %}
{% set oscodename = grains['oscodename'] | default(None) %}

repo {{ os_family }} remove saltstack repo:
    file.absent:
        - name:  /etc/apt/sources.list.d/saltstack.list
