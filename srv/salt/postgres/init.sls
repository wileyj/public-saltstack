---
postgres::external::admin:
    - 10.100.0.0/16
    - 10.20.0.0/16

postgres::external::slots_ro:
    - 0.0.0.0/0

postgres::external::slots_rw:
    - 0.0.0.0/0

postgres::version: "9.4"
postgres::short_version: "94"

postgres::conf::default_statistics_target:    "500"
postgres::conf::maintenance_work_mem:         "100MB"
postgres::conf::checkpoint_completion_target: "0.9"
postgres::conf::effective_cache_size:         "500MB"
postgres::conf::work_mem:                     "1536MB"
postgres::conf::wal_buffers:                  "16MB"
postgres::conf::checkpoint_segments:          "128"
postgres::conf::shared_buffers:               "500MB"
postgres::conf::max_connections:              "20"

postgres::classes:
    - firewall

postgres::packages:
    - postgresql94-libs
    - postgresql94
    - postgresql94-server
    - postgresql94-devel

postgres::services:
    - postgresql-9.4

postgres::files:
    /var/lib/pgsql:
        ensure : directory
        owner  : 'postgres'
        group  : 'postgres'
        replace: false
        recurse: false

    /var/lib/pgsql/9.4:
        ensure : directory
        owner  : 'postgres'
        group  : 'postgres'
        replace: false
        recurse: false

    /var/lib/pgsql/9.4/data:
        ensure : directory
        owner  : 'postgres'
        group  : 'postgres'
        replace: false
        recurse: false

    /root/postgres.sql:
        ensure : present
        owner  : 'root'
        group  : 'root'
        mode   : '0600'
        replace: true
        source : 'puppet:///modules/postgres/root/postgres.sql'

postgres::firewall::rules:
    '01-Postrouting-VPC':
        table:      'nat'
        chain:      'POSTROUTING'
        jump:       'MASQUERADE'
        proto:      'all'
        outiface:   "eth0"
        source:     "%{::network_eth0}/16"
        ensure:     'present'


        ---
        postgres::groups:
            postgres:
                ensure: present
                gid:    26
                members: [
                    'postgres'
                ]

        postgres::users:
            postgres:
                ensure: present
                home:   /var/lib/pgsql/9.4
                shell:  /bin/bash
                uid:    26
                gid:    26
