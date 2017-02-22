{% set global_modules = pillar['modules'] | default(None) %}
{% set global_modules_python = pillar['modules']['python'] | default(None) %}
{% set application = pillar['application'] | default(None) %}
{% set role = pillar['role']| default(None) %}

{% if role %}
{% set role_modules = pillar['role']['modules'] | default(None) %}
{% if role_modules %}
{% set role_modules_python = pillar['role']['modules']['python'] | default(None) %}
{% endif %}
{% endif %}

{% if application %}
{% set application_modules = pillar['application']['modules'] | default(None) %}
{% if application_modules %}
{% set application_modules_python = pillar['application']['modules']['python'] | default(None) %}
{% endif %}
{% endif %}


{% if global_modules and global_modules_python %}
    global python modules:
        pip.installed:
            - pkgs: {{ global_modules_python }}
            - upgrade: True
            - ignore_installed: True
{% endif %}

{% if application and application_modules and application_modules_python %}
    application python modules:
        pip.installed:
            - pkgs: {{ application_modules_python }}
            - upgrade: True
            - ignore_installed: True
{% endif %}

{% if role and role_modules and role_modules_python %}
    global python modules:
        pip.installed:
            - pkgs: {{ role_modules_python }}
            - upgrade: True
            - ignore_installed: True
{% endif %}
