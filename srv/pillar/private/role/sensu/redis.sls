redis:
  config:
    port: 6379
    listen: "0.0.0.0"
    dbfilename: "redisDB.rdb"
    rdb_dir: "/var/lib/redis/"
    masterip: "127.0.0.1"
    masterport: 6380
    masterauth: "masterauth_password"
    requirepass: "requirepass_password"
    command_config: "command_config_password"
    command_flushall: "command_flushall_password"
    command_flushdb: "command_flushdb_passwrord"
