class postgres::templates(
    $files                        = hiera('postgres::files', {}),
    $version                      = hiera('postgres::version'),
    $short_version                = hiera('postgres::short_version'),
    $postgres_iptables            = hiera('postgres::firewall::rules', {}),
    $default_statistics_target    = hiera('postgres::conf::default_statistics_target'),
    $maintenance_work_mem         = hiera('postgres::conf::maintenance_work_mem'),
    $checkpoint_completion_target = hiera('postgres::conf::checkpoint_completion_target'),
    $effective_cache_size         = hiera('postgres::conf::effective_cache_size'),
    $work_mem                     = hiera('postgres::conf::work_mem'),
    $wal_buffers                  = hiera('postgres::conf::wal_buffers'),
    $checkpoint_segments          = hiera('postgres::conf::checkpoint_segments'),
    $shared_buffers               = hiera('postgres::conf::shared_buffers'),
    $max_connections              = hiera('postgres::conf::max_connections'),
    $admin                        = hiera('postgres::external::admin',[]),
    $slots_ro                     = hiera('postgres::external::slots_ro',[]),
    $slots_rw                     = hiera('postgres::external::slots_rw',[]),
){
    create_resources('file',$files)
    notify{" INIT Postgres Templates " : } ->
    file{
        '/var/lib/pgsql/9.4/data/postmaster.opts':
            notify  => Service["postgresql-9.4"],
            ensure  => present,
            replace => true,
            owner   => 'postgres',
            group   => 'postgres',
            mode    => '0600',
            content => '/usr/pgsql-9.4/bin/postgres "-p" "5432" "-D" "/var/lib/pgsql/9.4/data"';
            #require => Package["postgresql94-server"];

        '/var/lib/pgsql/9.4/data/postgresql.conf':
            notify  => Service["postgresql-9.4"],
            ensure  => present,
            replace => true,
            owner   => 'postgres',
            group   => 'postgres',
            mode    => '0600',
            content => template('postgres/postgresql.conf.erb');
            #require => Package["postgresql94-server"];

        '/var/lib/pgsql/9.4/data/pg_ident.conf':
            notify  => Service["postgresql-9.4"],
            ensure  => present,
            replace => true,
            owner   => 'postgres',
            group   => 'postgres',
            mode    => '0600',
            source  => "puppet:///modules/postgres/var/lib/pgsql/9.4/data/pg_ident.conf";
            #require => Package["postgresql94-server"];

        '/var/lib/pgsql/9.4/data/pg_hba.conf':
            notify  => Service["postgresql-9.4"],
            ensure  => present,
            replace => true,
            owner   => 'postgres',
            group   => 'postgres',
            mode    => '0644',
            content => template('postgres/pg_hba.conf.erb');
            #require => Package["postgresql94-server"];
    }
}
