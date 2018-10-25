{% set ao_token = salt['pillar.get']('ao_token') %}

download_ao:
  cmd.run:
    - name: "bitsadmin /transfer mydownloadjob /download https://files.appoptics.com/windows-host-agent/appoptics-snaptel.msi %tmp%\\appoptics-snaptel.msi"

install_ao:
  cmd.run:
    - name: "msiexec /q /lv* appoptics.log /i %tmp%\\appoptics-snaptel.msi EULA=accept TOKEN={{ ao_token }}"
