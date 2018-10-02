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

ssl_no_verify_env:
  environ.setenv:
    - name:  GIT_SSL_NO_VERIFY
    - value: "1"
