
mariadb-install:
  pkg.installed:
    - name: mariadb-server

#MySQL config
mysql:
  service.running:
    {% if grains['os'] == 'CentOS' %}
    - name: mariadb
    {% elif grains['os'] == 'Ubuntu' %}
    - name: mysql
    {% endif %}
    - enable: True
    - reload: True
  cmd.run:
    ###should include a if verify
    - name: sudo mysql -e "CREATE USER 'appoptics'@'localhost' IDENTIFIED BY 'appoptics';" && mysql -e "GRANT ALL PRIVILEGES ON *.* TO appoptics@localhost;"

#configure appoptics mysql plugin
ao_plugin_file:
  file.managed:
    - name: /opt/appoptics/etc/plugins.d/mysql.yaml
    - source: salt://files/appoptics/plugins/mysql.yaml
    - user: appoptics
    - group: appoptics
    - mode: 644
  service.running:
    - name: appoptics-snapteld
    - restart: True
    - watch:
      - file: /opt/appoptics/etc/plugins.d/mysql.yaml

ao_task_file:
  file.managed:
    - name: /opt/appoptics/etc/tasks.d/task-aomysql.yaml
    - source: salt://files/appoptics/tasks/task-aomysql.yaml
    - user: appoptics
    - group: appoptics
    - mode: 644
  service.running:
    - name: appoptics-snapteld
    - restart: True
    - watch:
      - file: /opt/appoptics/etc/tasks.d/task-aomysql.yaml
