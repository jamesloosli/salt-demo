{% set role = salt['grains.get']('role','') %}

include:
  {% if role == 'saltmaster' %}
  - .master
  {% endif %}
  - .minion
