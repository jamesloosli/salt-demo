{% set os = salt['grains.get']('os') %}
{% set role = salt['grains.get']('role') %}

base:
  '*':
    - common

  'G@{{ os }}':
    - match: grain
    - os.{{ os }}

  'G@{{ role }}':
    - match: grain
    - role.{{ role }}
