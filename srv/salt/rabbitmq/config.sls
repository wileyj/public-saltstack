{% for name, plugin in salt["pillar.get"]("rabbitmq:plugin", {}).items() %}
{{ name }}:
  rabbitmq_plugin:
    {% for value in plugin %}
    - {{ value }}
    {% endfor %}
    - runas: root
    - require:
      - pkg: rabbitmq-server
    - watch_in:
      - service: rabbitmq-server
{% endfor %}

{% for name, policy in salt["pillar.get"]("rabbitmq:policy", {}).items() %}
{{ name }}:
  rabbitmq_policy.present:
    {% for value in policy %}
    - {{ value }}
    {% endfor %}
    - require:
      - service: rabbitmq-server
{% endfor %}

{% for name, vhost in salt["pillar.get"]("rabbitmq:vhost", {}).items() %}
rabbitmq_vhost_{{ name }}:
  rabbitmq_vhost.present:
    - name: {{ vhost }}
    - require:
      - service: rabbitmq-server
{% endfor %}

{% for name, user in salt["pillar.get"]("rabbitmq:user", {}).items() %}
rabbitmq_user_{{ name }}:
  rabbitmq_user.present:
    - name: {{ name }}
    {% for value in user %}
    - {{ value }}
    {% endfor %}
    - require:
      - service: rabbitmq-server
{% endfor %}


# disable the guest account
rabbitmq_disable_guest:
  rabbitmq_user.absent:
    - name: guest
    - runas: root
