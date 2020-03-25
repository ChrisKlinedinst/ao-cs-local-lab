#install apache
#ubuntu:
apache:
  pkg.installed:
    {% if grains['os'] == 'CentOS' %}
    - name: httpd
    {% elif grains['os'] == 'Ubuntu' %}
    - name: apache2
    {% endif %}

#start services
{% if grains['os'] == 'CentOS' %}
httpd:
  file.managed:
    - name: /etc/httpd/conf/httpd.conf
    - source: salt://files/httpd.conf
    - user: root
    - group: root
    - mode: 0644
    - skip_verify: true
  service.running:
    - name: httpd
    - enable: True
    - reload: True

{% elif grains['os'] == 'Ubuntu' %}
apache2:
  file.managed:
    - name: /etc/apache2/apache2.conf
    - source: salt://files/apache2.conf
    - user: root
    - group: root
    - mode: 0644
    - skip_verify: true
  service.running:
    - name: apache2
    - enable: True
    - reload: True

{% endif %}

#configure appoptics apache plugin
ao_plugin_file:
  file.managed:
    - name: /opt/SolarWinds/Snap/etc/plugins.d/apache.yaml
    - source: salt://files/appoptics/plugins/apache.yaml
    - user: solarwinds
    - group: solarwinds
    - mode: 644
  service.running:
    - name: swisnapd
    - restart: True
    - watch:
      - file: /opt/SolarWinds/Snap/etc/plugins.d/apache.yaml

ao_task_file:
  file.managed:
    - name: /opt/SolarWinds/Snap/etc/tasks.d/task-aoapache.yaml
    - source: salt://files/appoptics/tasks/task-aoapache.yaml
    - user: solarwinds
    - group: solarwinds
    - mode: 644
  service.running:
    - name: swisnapd
    - restart: True
    - watch:
      - file: /opt/SolarWinds/Snap/etc/tasks.d/task-aoapache.yaml
