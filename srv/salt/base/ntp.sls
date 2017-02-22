{% set ntp = pillar['ntp'] | default(None) %}
{% if ntp %}
    {% set servers = pillar['ntp']['servers'] | default(None) %}
    {% set restrictions = pillar['ntp']['restrictions'] | default(None) %}
    {% set tinker = pillar['ntp']['tinker'] | default(None) %}
    {% set driftfile = pillar['ntp']['driftfile'] | default(None) %}

    ntp:
      pkg:
        - installed
      service:
        {% if grains['os_family'] == 'RedHat' -%}
        - name: ntpd
        {% else %}
        - name: ntp
        {% endif %}
        - running
        - watch:
          - file: /etc/ntp.conf
      file.managed:
        - name: /etc/ntp.conf
        - source: salt://base/templates/ntp.conf.j2
        - mode: 644
        - template: jinja
        - defaults:
          servers: {{ servers }}
          restrictions: {{ restrictions }}
          tinker: {{ tinker }}
          driftfile: {{ driftfile }}
        - require:
          - pkg: ntp
{% endif %}
