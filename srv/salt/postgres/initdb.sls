class postgres::initdb (
    $version = hiera('postgres::version'),
){
    notify{" INIT Postgres initdb " : } ->
    exec {
      'InitDB':
        command => "/bin/chown postgres.postgres /var/lib/pgsql && /bin/rm -rf /var/lib/pgsql/${version}/data && /bin/su  postgres -c \"/usr/pgsql-${version}/bin/initdb /var/lib/pgsql/${version}/data -E UTF8\"",
        require =>  Package["postgresql${short_version}-server"],
        creates => "/var/lib/pgsql/${version}/data/PG_VERSION",
    }
}
