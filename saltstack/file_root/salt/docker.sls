#install docker
getdocker:
  cmd.run:
    - name: sudo bash -c "$(curl -sSLk https://get.docker.com -o get-docker.sh)" && sudo sh get-docker.sh
  pkg.installed:
    - name: python-docker

#start services
docker:
  service.running:
    - enable: True

#configure appoptics docker plugin
ao_plugin_file:
  cmd.run:
    - name:  sudo usermod -aG docker appoptics
  file.managed:
    - name: /opt/appoptics/etc/plugins.d/docker.yaml
    - source: salt://files/appoptics/plugins/docker.yaml
    - user: appoptics
    - group: appoptics
    - mode: 644
  service.running:
    - name: appoptics-snapteld
    - restart: True
    - watch:
      - file: /opt/appoptics/etc/plugins.d/docker.yaml

ao_task_file:
  file.managed:
    - name: /opt/appoptics/etc/tasks.d/task-aodocker.yaml
    - source: salt://files/appoptics/tasks/task-aodocker.yaml
    - user: appoptics
    - group: appoptics
    - mode: 644
  service.running:
    - name: appoptics-snapteld
    - restart: True
    - watch:
      - file: /opt/appoptics/etc/tasks.d/task-aodocker.yaml
