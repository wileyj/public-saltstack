postgres:
    version: "9.5"
    short_version: "95"
    external:
        admin:
            - 10.100.0.0/16
            - 10.20.0.0/16
        public:
            - 0.0.0.0/0
        private:
            - 0.0.0.0/0

    conf:
        default_statistics_target: 500
        maintenance_work_mem:         "100MB"
        checkpoint_completion_target: "0.9"
        effective_cache_size:         "500MB"
        work_mem:                     "1536MB"
        wal_buffers:                  "16MB"
        checkpoint_segments:          "128"
        shared_buffers:               "500MB"
        max_connections:              "20"

    packages:
        - postgresql94-libs
        - postgresql94
        - postgresql94-server
        - postgresql94-devel
    services:
        - postgresql-9.4

    firewall:
        rules:
            01-Postrouting-VPC:
                table:      'nat'
                chain:      'POSTROUTING'
                jump:       'MASQUERADE'
                proto:      'all'
                outiface:   "eth0"
                source:     "%{::network_eth0}/16"
                ensure:     'present'

    groups:
        postgres:
        ensure: present
        gid:    26
        members: [
            'postgres'
        ]

    users:
        postgres:
            ensure: present
            home:   /var/lib/pgsql/9.4
            shell:  /bin/bash
            uid:    26
            gid:    26
