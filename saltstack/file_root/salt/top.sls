{% set AO_TOKEN = 'f298b2330074fdd1ab4d85caca21cbc5fb312223a822d030dd202536afb9b297' %}

base:
  '*':
    - ao_token
    - git

  'G@type:host':
    - ao_host_agent

  'G@roles:docker':
    - docker
