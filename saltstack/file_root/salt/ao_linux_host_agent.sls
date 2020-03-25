{% set ao_token = salt['pillar.get']('ao_token') %}

run_installer:
  cmd.run:
    - name: sudo bash -c "$(curl -sSO https://files.solarwinds.cloud/solarwinds-snap-agent-installer.sh)" -s --token {{ ao_token }} --yes
