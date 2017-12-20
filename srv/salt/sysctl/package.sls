# -*- coding: utf-8 -*-
# vim: ft=sls

{## import settings from map.jinja ##}
{% from "sysctl/map.jinja" import sysctl_settings with context %}

install sysctl packages:
  pkg.installed:
    - name: {{ sysctl_settings.pkg }}
    - failhard: True
