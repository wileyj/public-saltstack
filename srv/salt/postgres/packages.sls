class postgres::packages(
    $packages = hiera('postgres::packages'),
){
    notify{" INIT Postgres Packages" : } ->
    package {
        $packages:
            ensure  => installed;
    }
}
