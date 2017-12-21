# redis.files
redis - /var/lib/redis:
  file.directory:
    - name: /var/lib/redis
    - user: root
    - group: root
    - mode: 755
    - makedirs: True
    - recurse:
      - user
      - group

redis - /etc/redis.d:
  file.directory:
    - name: /etc/redis.d
    - user: root
    - group: root
    - mode: 755
    - makedirs: True
    - recurse:
      - user
      - group

redis - /etc/init.d/redis:
  file.managed:
    - name: /etc/init.d/redis
    - source: salt://redis/files/etc/init.d/redis
    - user: root
    - group: root
    - mode: 0755

redis - /usr/lib/systemd/system/redis.service:
  file.managed:
    - name: /usr/lib/systemd/system/redis.service
    - source: salt://base/files/etc/systemd/redis
    - user: root
    - group: root
    - mode: 0644

/sys/kernel/mm/transparent_hugepage/enabled:
  file.managed:
    - name: /sys/kernel/mm/transparent_hugepage/enabled
    - content: 'never'
    - mode: 644
    - owner: root
    - group: root


/sys/kernel/mm/transparent_hugepage/defrag:
  file.managed:
    - name: /sys/kernel/mm/transparent_hugepage/defrag
    - content: 'never'
    - mode: 644
    - owner: root
    - group: root


rc.local - /sys/kernel/mm/transparent_hugepage/enabled:
  file.line:
    - name: /etc/rc.d/rc.local
    - content: 'echo never > /sys/kernel/mm/transparent_hugepage/enabled'
    - match: 'echo never > /sys/kernel/mm/transparent_hugepage/enabled'
    - after: '# that this script will be executed during boot.'
    - mode: ensure
    - location: end

rc.local - /sys/kernel/mm/transparent_hugepage/defrag:
  file.line:
    - name: /etc/rc.d/rc.local
    - content: 'echo never > /sys/kernel/mm/transparent_hugepage/defrag'
    - match: 'echo never > /sys/kernel/mm/transparent_hugepage/defrag'
    - after: 'echo never > /sys/kernel/mm/transparent_hugepage/enabled'
    - mode: ensure
    - location: end
