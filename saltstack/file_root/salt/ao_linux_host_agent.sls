{% set ao_token = salt['pillar.get']('ao_token') %}

run_installer:
  cmd.run:
    - name: sudo bash -c "$(curl -sSLk https://files.appoptics.com/appoptics-host-agent-installer.sh)" -s --token {{ ao_token }}
