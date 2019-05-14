{% from "swisnap/map.jinja" import swisnap with context %}
include:
  - swisnap.repo
solarwinds-snap-agent:
  pkg.installed:
    - version: {{ swisnap.version }}
    - require:
      - pkgrepo: swisnap_hostagent_repo
{% set token = salt['pillar.get']('ao_token') %}
{{ swisnap.config_base }}/config.yaml:
  file.managed:
    - template: jinja
    - user: root
    - group: root
    - mode: 0644
    - source: salt://swisnap/files/config.yaml.j2
    - context:
      plugin_config_path: {{ swisnap.plugin_config_path }}
      {% if salt['pillar.get']('swisnap.hostname', False) %}
      hostname: {{ swisnap.hostname }}
      {% endif %}
      fqdn_lookup: {{ swisnap.fqdn_lookup }}
      interval: {{ swisnap.interval }}
    - require:
      - pkg: appoptics-snaptel
swisnapd:
  service.running:
    - enable: True
    - require:
      - pkg: solarwinds-snap-agent
    - watch:
      - file: {{ swisnap.config_base }}/config.yaml
{% if swisnap.configured_plugins | length > 0 %}        
      - file: {{ swisnap.plugin_config_path }}/*
{% endif %}
{% if swisnap.configured_tasks | length > 0 %}        
      - file: {{ swisnap.task_config_path }}/*
{% endif %}