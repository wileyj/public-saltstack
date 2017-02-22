{% set sphinxsearch_version = pillar['role']['sphinxsearch_version'] | default(None) %}
{% set sphinxsearch_version_short = pillar['role']['sphinxsearch_version_short'] | default(None) %}
{% set sphinxsearch_dl_url = pillar['role']['sphinxsearch_version_dl_url'] | default(None) %}

{% if sphinxsearch_version and sphinxsearch_version_short and sphinxsearch_dl_url %}
    source_install sphinxsearch install - sphinxsearch-{{ sphinxsearch_version }}:
      pkg.installed:
        - sources:
          - sphinxsearch: {{ sphinxsearch_dl_url }}

    source_install sphinxsearch file edit - /etc/default/sphinxsearch:
        file.line:
            - match: "^START=*"
            - content: "START=yes"
            - mode: replace
            - indent: true
{% endif %}
