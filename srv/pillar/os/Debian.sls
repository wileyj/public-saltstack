{% set os = grains['os'] | default(None) %}
{% set oscodename = grains['oscodename'] | default(None) %}

packages:
    apache: apache2
    git: git-core
    java: openjdk
    jdk: openjdk
    python: python
    python-pip: python-pip
    python-setuptools: python-setuptools
    python-dev: python-dev
    ruby: ruby
    ruby-dev: ruby-dev
{% if os == 'Ubuntu' and oscodename == 'precise' %}
    rubygems: rubygems
{% else %}
    rubygems: ruby
{% endif %}
    rubygems-dev: ruby-dev
    perl:
        - perl
        - perl-base
        - perl-modules
    apt:
        - apt
        - vim-tiny
