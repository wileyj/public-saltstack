ntp:
  servers:
    - 0.amazon.pool.ntp.org
    - 1.amazon.pool.ntp.org
    - 2.amazon.pool.ntp.org
    - 3.amazon.pool.ntp.org      
  restrictions:
    - 'default kod nomodify notrap nopeer noquery'
    - '-6 default kod nomodify notrap nopeer noquery'
    - '127.0.0.1'
    - '-6 ::1'
  tinker: 'panic 0'
  driftfile: '/var/lib/ntp/drift'

