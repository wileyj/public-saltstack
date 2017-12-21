# services:
#   redis:
#     redis:
#       state: running
#       enabled: True
roles:
redis:
  services:
    redis:
      state: running
      enabled: True
  config:
    # port: 6379
    # listen: "0.0.0.0"
    timeout: 0
    loglevel: "notice"
    logfile: "/var/log/redis/redis.log"
    databases: 32
    tcp_backlog: 65536
    save_one: "900 1"
    save_two: "300 10"
    save_three: "60 10000"
    rdbcompression: "yes"
    # dbfilename: "redisDB.rdb"
    # rdb_dir: "/var/lib/redis/"
    # masterip: "127.0.0.1"
    # masterport: 6380
    # masterauth: "fe8606b201962cf338f40b1060b4d7b9c2c0bca5"
    slave_serve_stale_data: "yes"
    repl_ping_slave_period: 10
    repl_timeout: 60
    requirepass: ""
    command_config: ""
    command_flushall: ""
    command_flushdb: ""
    maxclients: 128
    maxmemory: 14830804992
    maxmemory_policy: "volatile-lru"
    appendonly: "yes"
    appendfsync: "everysec"
    no_appendfsync_on_rewrite: no
    auto_aof_rewrite_percentage: 100
    auto_aof_rewrite_min_size: 64
    slowlog_log_slower_than: 10000
    slowlog_max_len: 1024
    list_max_ziplist_entries: 512
    list_max_ziplist_value: 64
    set_max_intset_entries: 512
    zset_max_ziplist_entries: 128
    zset_max_ziplist_value: 64
    activerehashing: "yes"

sysctl:
  params:
    net.ipv4.tcp_timestamps : 0
    net.ipv4.tcp_window_scaling : 1
    net.ipv4.tcp_congestion_control : cubic
    net.ipv4.tcp_max_syn_backlog : 65536
    vm.overcommit_memory: 1
    vm.swappiness: 0

limits:
  users:
    '*':
      - limit_type: hard
        limit_item: nofile
        limit_value: 512000
      - limit_type: soft
        limit_item: nofile
        limit_value: 512000

logrotate:
  jobs:
    redis:
      path:
        - /var/log/redis/*.log
      config:
        - daily
        - missingok
        - rotate 7
        - compress
        - delaycompress
        - copytruncate
        - notifempty
        - create 640 root adm
        - sharedscripts
