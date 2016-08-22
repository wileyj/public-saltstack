base.packages:
  pkg.installed:
    - refresh: True
    - pkgs: {{ pillar['packages']['base'] }}
{% if grains['os'] == 'CentOS' or grains['os'] == 'Amazon' %}
rpm.packages:
  pkg.installed:
    - pkgs: {{ pillar['packages']['yum'] }}
{% elif grains['os'] == 'Ubuntu' or grains['os'] == 'Debian' %}
apt.packages:
  pkg.installed:
    - pkgs: {{ pillar['packages']['apt'] }}
{% endif %}
