wileyj at Jesses-MacBook-Air in ~/git/ops-puppet/code/modules/rtg on params-refactor [!$]$ cat jenkins/manifests/services.pp
class jenkins::services(
    $services = hiera('jenkins::services',[]),
){
    notify{" INIT Jenkins Services" : } ->
    service {
        $services:
            ensure => running,
            enable => true,
            path => '/etc/init.d'
    }
}
wileyj at Jesses-MacBook-Air in ~/git/ops-puppet/code/modules/rtg on params-refactor [!$]$ cat jenkins/manifests/
cron.pp       init.pp       packages.pp   params.pp     services.pp   sudo.pp       sumo.pp       templates.pp  users.pp

wileyj at Jesses-MacBook-Air in ~/git/ops-puppet/code/modules/rtg on params-refactor [!$]$ cat jenkins/manifests/
cron.pp       init.pp       packages.pp   params.pp     services.pp   sudo.pp       sumo.pp       templates.pp  users.pp

wileyj at Jesses-MacBook-Air in ~/git/ops-puppet/code/modules/rtg on params-refactor [!$]$ cat jenkins/manifests/templates.pp
class jenkins::templates(
    $files = hiera('jenkins::files', {}),
){
    notify{" INIT Jenkins templates " : }
    create_resources('file',$files)
}
wileyj at Jesses-MacBook-Air in ~/git/ops-puppet/code/modules/rtg on params-refactor [!$]$ cat jenkins/manifests/cron.pp
class jenkins::cron(
    $cron = hiera('jenkins::cron', {}),
){
    notify{" INIT Jenkins cron " : }
    create_resources('cron::job',$cron)
}
wileyj at Jesses-MacBook-Air in ~/git/ops-puppet/code/modules/rtg on params-refactor [!$]$ cat packc

wileyj at Jesses-MacBook-Air in ~/git/ops-puppet/code/modules/rtg on params-refactor [!$]$ cat jenkins/manifests/packages.pp
class jenkins::packages(
    $packages = hiera('jenkins::packages',[]) ,
){
    notify{" INIT Jenkins Packages " : } ->
    package {
        $packages:
            ensure  => latest;
    }
}
