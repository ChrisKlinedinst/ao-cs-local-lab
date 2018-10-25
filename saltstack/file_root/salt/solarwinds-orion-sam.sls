{% set ao_token = salt['pillar.get']('ao_token') %}

##get Orion SAM 6.7  installer
download_sam:
  cmd.run:
    - name: "bitsadmin /transfer orionDownloadJob /download https://downloads.solarwinds.com/solarwinds/OfflineInstallers/RTM/SAM/Solarwinds-Orion-SAM-6.7-OfflineInstaller.exe c:\\tmp\\orion-sam-installer.exe"

##get xml config for silet install
orion_conf:
  file.managed:
    - name: c:\\tmp\\orion.conf
    - source: salt://files/orion.conf

##install Orion SAM 6.7 silent
install_sam:
  cmd.run:
    - name: "start /wait "c:\\tmp\\orion-sam-installer.exe" /s /ConfigFile="c:\\tmp\\orion.conf""

##get APM .Net Agent
download_apm:
  cmd.run:
    - name: "bitsadmin /transfer apmDownloadJob /download https://files.appoptics.com/dotnet/DotNetAgent_Setup.exe c:\\tmp\\DotNetAgent_Setup.exe"

##Set env var for servicekey
aotoken_env:
  environ.setenv:
    - name: APPOPTICS_SERVICE_KEY
    - value: {{ ao_token }}:sam
    - update_minion: True

##install APM .Net silent
install_apm:
  cmd.run:
    - name: ""c:\\tmp\\DotNetAgent_Setup.exe" [/SILENT | /VERYSILENT] /COMPONENTS="IISOnly[,NonIISApplications]" [/CLOSEAPPLICATIONS | /NOCLOSEAPPLICATIONS]"
