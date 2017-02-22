# application users
{% set application = pillar['application'] | default(None) %}
{% if application %}
{% set users = pillar['application']['users'] | default(None) %}
{% set groups = pillar['application']['groups'] | default(None) %}
{% if users %}
{% for key,val in users.iteritems() %}
application users - {{ key }}:
    user.present:
        - name: {{ val['name'] }}
        - fullname: {{ val['name'] }}
        - shell: {{ val['shell'] }}
    {% if val['home'] is defined %}
        - home: {{ val['home'] }}
    {% endif %}
        - uid: {{ val['uid'] }}
{% endfor %}
{% endif %}

{% if groups %}
{% for key,val in groups.iteritems() %}
application groups - {{ key}}:
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
