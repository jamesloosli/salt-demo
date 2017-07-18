{% set os = salt['grains.get']('os') %}
{% set role = salt['grains.get']('role') %}

base:
  '*':
    - common

  'os:{{ os }}':
    - match: grain
    - os.{{ os }}

  'role:{{ role }}':
    - match: grain
    - role.{{ role }}
