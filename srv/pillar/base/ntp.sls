# base.ntp
ntp:
  servers:
{% if grains['virtual_subtype'] != 'Docker' or grains['virtual_subtype'] != 'docker' %}
    - 0.amazon.pool.ntp.org
    - 1.amazon.pool.ntp.org
    - 2.amazon.pool.ntp.org
    - 3.amazon.pool.ntp.org
{% else %}
    # else, use public ones
    - time.nist.gov
{% endif %}
  restrictions:
    - 'default kod nomodify notrap nopeer noquery'
    - '-6 default kod nomodify notrap nopeer noquery'
    - '127.0.0.1'
    - '-6 ::1'
  tinker: 'panic 0'
  driftfile: '/var/lib/ntp/drift'
