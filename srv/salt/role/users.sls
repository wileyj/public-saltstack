{% set role = pillar['role'] | default(None) %}
{% if role %}
{% set users = pillar['role']['users'] | default(None) %}
{% set groups = pillar['role']['groups'] | default(None) %}
{% if users %}
{% for key,val in users.iteritems() %}
role user - {{ key }}:
    user.present:
        - name: {{ val['name'] }}
        - fullname: {{ val['name'] }}
        - shell: {{ val['shell'] }}
    {% if val['home'] is defined %}
        - home: {{ val['home'] }}
    {% endif %}
    {% if val['createhome'] is defined %}
        - createhome: {{ val['createhome'] }}
    {% endif %}
        - uid: {{ val['uid'] }}
{% endfor %}
{% endif %}

{% if groups %}
{% for key,val in groups.iteritems() %}
role groups - {{ key}}:
    group.present:
        - name: {{ val['name'] }}
        - system: {{ val['system'] }}
        - gid: {{ val['gid'] }}
    {% if val['addusers'] is defined %}
        - members:
        {% for key in val['addusers'] %}
            - {{ key }}
        {% endfor %}
    {% endif %}
{% endfor %}
{% endif %}
{% endif %}
