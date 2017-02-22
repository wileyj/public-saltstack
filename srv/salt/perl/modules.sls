{% set global_modules = pillar['modules'] | default(None) %}
{% set global_modules_perl = pillar['modules']['perl'] | default(None) %}
{% set application = pillar['application'] | default(None) %}
{% set role = pillar['role']| default(None) %}

{% if role %}
{% set role_modules = pillar['role']['modules'] | default(None) %}
{% if role_modules %}
{% set role_modules_perl = pillar['role']['modules']['perl'] | default(None) %}
{% endif %}
{% endif %}

{% if application %}
{% set application_modules = pillar['application']['modules'] | default(None) %}
{% if application_modules %}
{% set application_modules_perl = pillar['application']['modules']['perl'] | default(None) %}
{% endif %}
{% endif %}

{% if global_modules and global_modules_perl %}
    {% for module in global_modules_perl %}
        perl module global install - {{ module }}:
            module.run:
                - name: cpan.install
                - module: {{ module }}
    {% endfor %}
{% endif %}

{% if application and application_modules and application_modules_perl %}
    {% for module in application_modules_perl %}
        perl application global install - {{ module }}:
            module.run:
                - name: cpan.install
                - module: {{ module }}
    {% endfor %}
{% endif %}

{% if role and role_modules and role_modules_perl %}
    {% for module in role_modules_perl %}
        perl role global install - {{ module }}:
            module.run:
                - name: cpan.install
                - module: {{ module }}
    {% endfor %}
{% endif %}
