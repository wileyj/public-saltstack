# users.sensu
users:
  sensu:
    fullname: Sensu User
    uid: 487
    gid: 487
    shell: /bin/bash
    home: /opt/sensu
    groups:
      - sensu
      - monitoring

groups:
  monitoring:
    name: monitoring
    gid: 488
    system: False
  sensu:
    name: sensu
    gid: 487
    system: False
