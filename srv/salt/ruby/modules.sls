{% set global_modules = pillar['modules'] | default(None) %}
{% set global_modules_ruby = pillar['modules']['ruby'] | default(None) %}
{% set application = pillar['application'] | default(None) %}
{% set role = pillar['role']| default(None) %}

{% if role %}
{% set role_modules = pillar['role']['modules'] | default(None) %}
{% if role_modules %}
{% set role_modules_ruby = pillar['role']['modules']['ruby'] | default(None) %}
{% endif %}
{% endif %}

{% if application %}
{% set application_modules = pillar['application']['modules'] | default(None) %}
{% if application_modules %}
{% set application_modules_ruby = pillar['application']['modules']['ruby'] | default(None) %}
{% endif %}
{% endif %}



{% if global_modules and global_modules_ruby %}
    global ruby modules:
        gem.installed:
            - names: {{ global_modules_ruby }}
{% endif -%}

{% if application and application_modules and application_modules_ruby %}
    application ruby modules:
        gem.installed:
            - names: {{ application_modules_ruby }}
{% endif -%}

{% if role and role_modules and role_modules_ruby %}
    role ruby modules:
        gem.installed:
            - names: {{ role_modules_ruby }}
{% endif -%}
