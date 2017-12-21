#base.users
{% for group, args in pillar['groups'].iteritems() %}
{{ group }}_group:
  group.present:
    - name: {{ group }}
{% if 'gid' in args %}
    - gid: {{ args['gid'] }}
{% endif %}
{% endfor %}

{% for user, args in pillar['users'].iteritems() %}
{{ user }}_user:
{% if 'gid_from_name' in args and args['gid_from_name'] == 'True' %}
  group.present:
    - name: {{ user }}
    - gid: {{ args['gid'] }}
{% endif %}
  user.present:
    - name: {{ user }}
    - home: {{ args['home'] }}
    - shell: {{ args['shell'] }}
    - uid: {{ args['uid'] }}
    - gid: {{ args['gid'] }}
{% if 'password' in args %}
    - password: {{ args['password'] }}
{% if 'enforce_password' in args %}
    - enforce_password: {{ args['enforce_password'] }}
{% endif %}
{% endif %}
    - fullname: {{ args['fullname'] }}
{% if 'groups' in args %}
    - groups: {{ args['groups'] }}
{% endif %}
{% if 'gid_from_name' in args %}
    - gid_from_name: {{ args['gid_from_name'] }}
{% endif %}
{% if 'createhome' in args %}
    - createhome: {{ args['createhome'] }}
{% endif %}
{% if 'unique' in args %}
    - unique: {{ args['unique'] }}
{% endif %}
{% if grains['role'] != "bastion" %}
{% if user == args['gid'] %}
    - require:
      - group: {{ user }}
{% endif %}
  file.directory:
    - name: {{ args['home'] }}/.ssh
    - user: {{ args['uid'] }}
    - group: {{ args['gid'] }}
    - mode: 700
{% if 'pubkey' in args %}
{{ user }}_keyfile:
  file.managed:
    - name: {{ args['home'] }}/.ssh/authorized_keys
    - user: {{ user }}
    - group: {{ args['gid'] }}
    - mode: '0644'
    - contents: {{ args['pubkey'] }}
{% endif %}
{% else %}
  {% if 'pubkey' in args %}
{{ user }}_keyfile:
  file.managed:
    - name: /etc/ssh/authorized_keys/{{ user }}
    - user: root
    - group: root
    - mode: '0644'
    - contents: {{ args['pubkey'] }}
  {% endif %}
{% endif %}
{% endfor %}
