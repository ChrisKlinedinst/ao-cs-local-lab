{% from "swisnap/map.jinja" import swisnap with context %}
{% if grains['os_family'] == 'RedHat' %}
swisnap_hostagent_repo:
  pkgrepo.managed:
    - humanname: 'swisnap_{{ swisnap.repo_base }}'
    - baseurl: '{{ swisnap.repo_url }}/{{ swisnap.repo_base }}/{{ swisnap.distro }}/{{ swisnap.repo_release }}/$basearch'
    - gpgcheck: 0
{% elif grains['os_family'] == 'Debian' %}
swisnap_hostagent_repo:
  pkgrepo.managed:
    - humanname: 'swisnap_{{ swisnap.repo_base }}'
    - name: 'deb {{ swisnap.repo_url }}/{{ swisnap.repo_base }}/{{ swisnap.platform }} {{ swisnap.dist }} main'
    - file: '/etc/apt/sources.list.d/swisnap_{{ swisnap.repo_base }}.list'
    - dist: {{ swisnap.dist }}
    - key_url: 'https://packagecloud.io/solarwinds/swisnap/gpgkey'
{% endif %}