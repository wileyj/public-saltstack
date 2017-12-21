# base.base
services:
  # base:
  auditd:
    state: running
    enabled: True
  cloud-config:
    state: running
    enabled: True
  cloud-final:
    state: running
    enabled: True
  cloud-init:
    state: running
    enabled: True
  cloud-init-local:
    state: running
    enabled: True
  messagebus:
    state: running
    enabled: True
  crond:
    state: running
    enabled: True
  network:
    state: running
    enabled: True
  ntpd:
    state: running
    enabled: True
  rsyslog:
    state: running
    enabled: True
  sysstat:
    state: running
    enabled: True
