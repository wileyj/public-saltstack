# role:shared init
{% set current_path = salt['environ.get']('PATH', '/bin:/usr/bin') %}
