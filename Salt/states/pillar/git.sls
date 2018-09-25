#install git
github:
  pkg.installed:
    - name: git

#create local repo
/srv/git:
  file.directory:
    - user: vagrant
    - group: vagrant
    - mode: 755
    - makedirs: True
