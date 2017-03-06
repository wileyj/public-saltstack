# postgres.templates
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
