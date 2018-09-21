run_installer:
  cmd.run:
    - name: sudo bash -c "$(curl -sSLk https://files.appoptics.com/appoptics-host-agent-installer.sh)" -s --token $APPOPTICS_API_TOKEN
