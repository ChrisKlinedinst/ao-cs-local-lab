mesos:
  {% if grains['os'] == 'Ubuntu' %}
  pkgrepo.managed:
    - humanname: Mesos repo
    - name: deb http://repos.mesosphere.com/ubuntu xenial main
    - keyid: E56151BF
    - keyserver: keyserver.ubuntu.com
    - file: /etc/apt/sources.list.d/mesosphere.list
  pkg.installed:
    - name: mesos
  service.running:
    - name: mesos-slave

  {% elif grains['os'] == 'CentOS' %}
  cmd.run:
    - name: sudo bash -c "http://repos.mesosphere.io/el/7/noarch/RPMS/mesosphere-el-repo-7-1.noarch.rpm"
  pkg.installed:
    - name: mesos
  service.running:
    - name:
      - mesos-master
#      - mesos-slave
    {% endif %}


ao_plugin_file:
  file.managed:
    - name: /opt/SolarWinds/Snap/etc/plugins.d/mesos.yaml
    - source: salt://files/appoptics/plugins/mesos.yaml
    - user: solarwinds
    - group: solarwinds
    - mode: 644
  service.running:
    - name: swisnapd
    - restart: True
    - watch:
      - file: /opt/SolarWinds/Snap/etc/plugins.d/mesos.yaml

ao_task_file:
  file.managed:
    - name: /opt/SolarWinds/Snap/etc/tasks.d/task-aomesos.yaml
    - source: salt://files/appoptics/tasks/task-aomesos.yaml
    - user: solarwinds
    - group: solarwinds
    - mode: 644
  service.running:
    - name: swisnapd
    - restart: True
    - watch:
      - file: /opt/SolarWinds/Snap/etc/tasks.d/task-aomesos.yaml
