#install collectd
collectd_install:
  pkg.installed:
    - name: collectd

collectd.conf:
  file.managed:
    {% if grains['os'] == 'CentOS' %}
    - name: /etc/collectd.d/collectd.conf
    {% elif grains['os'] == 'Ubuntu' %}
    - name: /etc/collectd/collectd.conf
    {% endif %}
    - source: salt://files/collectd.conf
    - user: root
    - group: root
    - mode: 0644
    - skip_verify: true

#start services
collectd_service:
  service.running:
  - name: collectd
  - enable: True
  - restart: True

#configure appoptics apache plugin
ao_plugin_file:
  file.managed:
    - name: /opt/SolarWinds/Snap/etc/plugins.d/collectd_listener.yaml
    - source: salt://files/appoptics/plugins/collectd_listener.yaml
    - user: solarwinds
    - group: solarwinds
    - mode: 644
  service.running:
    - name: swisnapd
    - restart: True
    - watch:
      - file: /opt/SolarWinds/Snap/etc/plugins.d/collectd_listener.yaml

ao_task_file:
  file.managed:
    - name: /opt/SolarWinds/Snap/etc/tasks.d/task-bridge-collectd_listener.yaml
    - source: salt://files/appoptics/tasks/task-bridge-collectd_listener.yaml
    - user: appoptics
    - group: appoptics
    - mode: 644
  service.running:
    - name: swisnapd
    - restart: True
    - watch:
      - file: /opt/SolarWinds/Snap/etc/tasks.d/task-bridge-collectd_listener.yaml
