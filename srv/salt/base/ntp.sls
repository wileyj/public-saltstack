ntp:
  pkg:
    - installed
  service:
    {% if grains['os'] == 'CentOS' or grains['os'] == 'Amazon' %}
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
      servers: {{ pillar['ntp']['servers'] }}
      restrictions: {{ pillar['ntp']['restrictions'] }}
      tinker: {{ pillar['ntp']['tinker'] }}
      driftfile: {{ pillar['ntp']['driftfile'] }}
    - require:
      - pkg: ntp
