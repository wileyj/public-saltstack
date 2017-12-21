# os.RedHat
logrotate:
  lookup:
    pkg: logrotate
    service: crond
packages:
  os:
    - yum
    - vim-minimal
  apache:
    - httpd
  git:
    - git
  jdk:
    - jdk
  ruby:
    - ruby
    - ruby-devel
    - rubygems
    - rubygems-devel
  perl:
    - perl
