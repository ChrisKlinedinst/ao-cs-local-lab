#install docker
getdocker:
  cmd.run:
    - name: sudo bash -c "$(curl -sSLk https://get.docker.com -o get-docker.sh)" && sudo sh get-docker.sh
#    - RunScript: sudo sh get-docker.sh

getdockercompose:
  cmd.run:
    - name: sudo curl -kL "https://github.com/docker/compose/releases/download/1.22.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

#start services
docker:
  service.running:
    - enable: True

#configure appoptics docker plugin
ao_plugin:
  cmd.run:
    - name:  sudo usermod -aG docker appoptics
  file.copy:
    - name: /opt/appoptics/etc/plugins.d/docker.yaml
    - source: /opt/appoptics/etc/plugins.d/docker.yaml.example
    - preserve: False
    - force: False
    - user: appoptics
    - group: appoptics
    - mode: 644
  service.running:
    - name: appoptics-snapteld
    - restart: True
    - watch:
      - file: /opt/appoptics/etc/plugins.d/docker.yaml
