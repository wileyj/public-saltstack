rabbitmqrole:
  path: 
    - /sbin
    - /bin
    - /usr/sbin
    - /usr/bin
    - $HOME/bin
    - /usr/local/bin
    - /usr/local/sbin
    - /usr/pgsql-9.5/bin
    
  graphite:
    modules:
      - whisper
      - carbon-client
      - carbonstat
      - carbon
      - graphite-web
      - django
      - twisted
      - django-tagging
      - uWSGI
      - uwsgi_metrics
      - django-uwsgi
      - django-uwsgi-admin2
      - elasticsearch-curator
      - elasticsearch-scripts
      - elasticstats
      - elasticstat
      - pyelasticsearch
      - elasticsearch
      - cairocffi
      - psycopg2
      - psycopg2-managed-connection
      - db-psycopg2
      - pgsql_wrapper
      - psycopg2cffi
      - psycopg2cffi-compat

    packages:
      - m4
      - libffi-devel
      - cairo-devel
      - pycairo-devel
      - python27-pycairo
      - python27-pycairo-devel
      - cairo

    services:
      - graphite

    cache:
      storage_dir: /opt/graphite/storage
      local_data_dir: /opt/graphite/storage/whisper
      whitelists_dir: /opt/graphite/storage/lists
      conf_dir: /opt/graphite/conf
      log_dir: /var/log/graphite
      pid_dir: /var/run/
      user: root
      max_cache_size: inf
      max_updates_per_second: 500
      max_creates_per_minute: 50
      line_receiver_interface: 0.0.0.0
      line_receiver_port: 2003
      enable_udp_listener: False
      udp_receiver_interface: 0.0.0.0
      udp_receiver_port: 2003
      pickle_receiver_interface: 0.0.0.0
      pickle_receiver_port: 2004
      use_insecure_unpickler: False
      cache_query_interface: 0.0.0.0
      cache_query_port: 7002
      use_flow_control: True
      log_updates: False
      whisper_autoflush: False
      amqp_verbose: False
      amqp_vhost: /
      amqp_exchange: graphite
      amqp_metric_name_in_body: False

    relay:
    line_receiver_interface: 0.0.0.0
    line_receiver_port: 2013
    pickle_receiver_interface: 0.0.0.0
    pickle_receiver_port: 2014
    relay_method: rules
    replication_factor: 1
    destinations: 127.0.0.1:2004

    aggregator:
      line_receiver_interface: 0.0.0.0
      line_receiver_port: 2023
      pickle_receiver_interface: 0.0.0.0
      pickle_receiver_port: 2024
      destinations: 127.0.0.1:2004
      replication_factor:  1
      max_queue_size: 10000
      use_flow_control: True
      max_datapoints_per_message: 500
      max_aggregation_intervals: 5

    storage-schemas:
      pattern: '^carbon\.'
      retentions: 60:90d

  dashboard:
    ui:
      default_graph_width: 400
      default_graph_height: 250
      automatic_variants: true
      refresh_interval: 60
      autocomplete_delay: 375
      merge_hover_delay: 750
      theme: default
    keyboard:
      toggle_toolbar: ctrl-z
      toggle_metrics_panel: ctrl-space
      erase_all_graphs: alt-x
      save_dashboard: alt-s
      completer_add_metrics: alt-enter
      completer_del_metrics: alt-backspace
      give_completer_focus: shift-space

    local:
      time_zone: America/New_York
      documentation_url: http://graphite.readthedocs.org/
      log_rendering_performance: True
      log_cache_performance: True
      log_metric_access: True
      debug: True
      flushrrdcached: unix:/var/run/rrdcached.sock
      memcache_hosts:
        - 10.10.10.10:11211
        - 10.10.10.11:11211
        - 10.10.10.12:11211
      default_cache_duration: 60
      secret_key: secret_key
      graphite_root: /opt/graphite
      conf_dir: /opt/graphite/conf
      storage_dir: /opt/graphite/storage
      content_dir: /opt/graphite/webapp/content
      dashboard_conf: /opt/graphite/conf/dashboard.conf
      graphtemplates_conf: /opt/graphite/conf/graphTemplates.conf
      whisper_dir: /opt/graphite/storage/whisper
      rrd_dir: /opt/graphite/storage/rrd
      data_dirs:
      - /opt/graphite/storage/whisper
      - /opt/graphite/storage/rrd
      log_dir: /opt/graphite/storage/log/webapp
      index_file: /opt/graphite/storage/index
      email_backend: django.core.mail.backends.smtp.EmailBackend
      email_host: localhost
      email_port: 25
      email_host_user: ""
      email_host_password: ""
      email_use_tls: False
      use_remote_user_authentication: True
      login_url: /account/login
      database_engine: django.db.backends.postgresql_psycopg2
      database_name: graphite
      database_user: graphite
      database_password: dbpassowrd
      database_host: 127.0.0.1
      database_port: 5432
      cluster_servers:
        - 10.0.2.2:80
        - 10.0.2.3:80
      remote_store_fopth_timeout: 6
      remote_store_find_timeout: 2.5
      remote_store_retry_delay: 60
      remote_find_cache_duration: 300
      remote_rendering: True
      rendering_hosts: ""
      remote_render_connect_timeout: 1.0
      carbonlink_hosts:
        - 127.0.0.1:7002:a
        - 127.0.0.1:7102:b
        - 127.0.0.1:7202:c
      carbonlink_timeout: 1.0

  uwsgi:
    binary_path: /usr/local/bin/uwsgi
    processes: 2
    socket: 127.0.0.1:3031
    wsgi_file: /opt/graphite/webapp/graphite/graphite.wsgi
    gid: nginx
    uid: nginx
    module: wsgi:application
    daemonize: /var/log/uwsgi/daemon.log
    chown_socket: nginx
    die_on_term: true
    emperor: true
    enable_threads: true
    limit_as: 512
    master: true
    vacuum: true
    vhost: true
    workers: 4


