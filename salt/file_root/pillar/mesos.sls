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
    - name: mesos-master
#      - mesos-slave
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
    - name: /opt/appoptics/etc/plugins.d/mesos.yaml
    - source: salt://files/appoptics/plugins/mesos.yaml
    - user: appoptics
    - group: appoptics
    - mode: 644
  service.running:
    - name: appoptics-snapteld
    - restart: True
    - watch:
      - file: /opt/appoptics/etc/plugins.d/mesos.yaml

ao_task_file:
  file.managed:
    - name: /opt/appoptics/etc/tasks.d/task-aomesos.yaml
    - source: salt://files/appoptics/tasks/task-aomesos.yaml
    - user: appoptics
    - group: appoptics
    - mode: 644
  service.running:
    - name: appoptics-snapteld
    - restart: True
    - watch:
      - file: /opt/appoptics/etc/tasks.d/task-aomesos.yaml
