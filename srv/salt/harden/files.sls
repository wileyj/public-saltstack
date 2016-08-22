{% if grains['os'] == 'CentOS' or grains['os'] == 'Amazon' %}
/etc/profile.d/os-security.sh:
    file.managed:
      - user: root
      - group: root
      - mode: 0755
      - contents:
        - "readonly TMOUT=900"
        - "readonly HISTFILE"
{% endif %}
