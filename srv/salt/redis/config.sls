#redis.config
redis config - /etc/redis.conf:
  file.managed:
    - name: /etc/redis.conf
    - owner: root
    - group: root
    - mode: 0444
    - template: jinja
    - source: salt://redis/templates/redis.conf.jinja


#     notify{" INIT Redis exec " : } ->
#     exec {
#         "/bin/echo never > /sys/kernel/mm/transparent_hugepage/enabled":
#             path    => "/usr/bin:/usr/sbin:/bin",
#             unless  => "grep '[never]' /sys/kernel/mm/transparent_hugepage/enabled 2>/dev/null",
#             onlyif => '/usr/bin/test -f /sys/kernel/mm/transparent_hugepage/enabled';
#
#         "/bin/echo '00000000,00000003' > /sys/class/net/eth0/queues/rx-0/rps_cpus":
#             path    => "/usr/bin:/usr/sbin:/bin",
#             unless  => "grep '3' /sys/class/net/eth0/queues/rx-0/rps_cpus 2>/dev/null",
#             onlyif => '/usr/bin/test -f /sys/class/net/eth0/queues/rx-0/rps_cpus';
#     }
# }
