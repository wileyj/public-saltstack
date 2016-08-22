#####################################
##### Salt Formula For Resolver #####
#####################################

{% set is_resolvconf_enabled = grains['os'] == 'Ubuntu' and salt['pkg.version']('resolvconf') %}

# Resolver Configuration
resolv-file:
  file.managed:
    {% if is_resolvconf_enabled %}
    - name: /etc/resolvconf/resolv.conf.d/base
    {% else %}
    - name: /etc/resolv.conf
    {% endif %}
    - user: root
    - group: root
    - mode: '0644'
    - source: salt://resolver/templates/resolv.conf.j2
    - template: jinja
    - defaults:
        nameservers: {{ salt['pillar.get']('resolver:nameservers', [salt['grains.get']('ec2-data:ec2-network:gateway')]) }}
        searchpaths: {{ salt['pillar.get']('resolver:searchpaths', [salt['grains.get']('domain'), salt['grains.get']('ec2-data:ec2-tags:region_searchpath'),salt['pillar.get']('domain') ]) }}
        options: {{ salt['pillar.get']('resolver:options', ['rotate','timeout:1']) }}
        domain: {{ salt['pillar.get']('domain') }}

{% if is_resolvconf_enabled %}
resolv-update:
  cmd.run:
    - name: resolvconf -u
    - onchanges:
      - file: resolv-file
{% endif %}
