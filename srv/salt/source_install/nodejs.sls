{% set os_family = grains['os_family'] | default(None) %}
{% set oscodename = grains['oscodename'] | default(None) %}
{% if oscodename and os_family == 'Debian' %}
    source_install nodejs repo main:
        pkgrepo.managed:
            - humanname: nodejs
            - name: deb https://deb.nodesource.com/node_5.x {{ oscodename }} main
            - file: /etc/apt/sources.list.d/nodesource.list
            - gpgcheck: 1
            - key_url: http://deb.nodesource.com/gpgkey/nodesource.gpg.key
            - clean_file: true
            - disabled: false
            - refresh_db: true

    source_install nodejs repo src:
        pkgrepo.managed:
            - humanname: nodejs src
            - name: deb-src https://deb.nodesource.com/node_6.x {{ oscodename }} main
            - file: /etc/apt/sources.list.d/nodesource.list
            - gpgcheck: 1
            - key_url: http://deb.nodesource.com/gpgkey/nodesource.gpg.key
            - clean_file: false
            - disabled: false
            - refresh_db: true

    source_install nodejs packages:
        pkg.installed:
            - fromrepo: {{ oscodename }}
            - pkgs:
                - nodejs
{% endif %}
