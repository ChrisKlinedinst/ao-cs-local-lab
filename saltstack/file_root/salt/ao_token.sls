{% set ao_token = salt['pillar.get']('ao_token') %}

aotoken_env:
  environ.setenv:
    - name: APPOPTICS_API_TOKEN
    - value: {{ ao_token }}
    - update_minion: True
