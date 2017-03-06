# php.modules
{% set global_modules = pillar['modules'] | default(None) %}
{% set global_modules_php = pillar['modules']['php'] | default(None) %}
{% set application = pillar['application'] | default(None) %}
{% set role = pillar['role']| default(None) %}

{% if role %}
{% set role_modules = pillar['role']['modules'] | default(None) %}
{% if role_modules %}
{% set role_modules_php = pillar['role']['modules']['php'] | default(None) %}
{% endif %}
{% endif %}

{% if application %}
{% set application_modules = pillar['application']['modules'] | default(None) %}
{% if application_modules %}
{% set application_modules_php = pillar['application']['modules']['php'] | default(None) %}
{% endif %}
{% endif %}

{% if global_modules and global_modules_php %}
    global php modules:
        pecl.installed:
            - pecls: {{ global_modules_php }}
{% endif -%}

{% if application and application_modules and application_modules_php %}
    application php modules:
        pecl.installed:
            - pecls: {{ application_modules_php }}
{% endif -%}

{% if role and role_modules and role_modules_php %}
    role php modules:
        pecl.installed:
            - pecls: {{ role_modules_php }}
{% endif -%}
