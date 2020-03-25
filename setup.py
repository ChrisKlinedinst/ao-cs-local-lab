#!/user/bin/env python3

import os, sys, subprocess, string

path = os.getcwd()

#set lab home path
os.environ["LAB_HOME"] = path

token = str(raw_input("enter your AppOptics token\n you can find a list of available tokens here: https://my.appoptics.com/organization/tokens:"))

aosalt = open("saltstack/file_root/pillar/appoptics.sls", 'w')
aosalt.write("ao_token: "+token+"\n")
aosalt.close()

##verify vbox version
##every subprocess needs rescue message
vbox = subprocess.Popen(['VBoxManage','--version'], cwd=path)

if not vbox:
    print ("Virtualbox is not installed")

elif vbox:
    print("Installing VBox Guest Additions")
    p = subprocess.Popen(['vagrant', 'plugin', 'install', 'vagrant-vbguest'], cwd=path)
    print("remove default VBox DHCP server")
    p = subprocess.Popen(['VBoxManage', 'dhcpserver', 'remove', '--netname', 'HostInterfaceNetworking-vboxnet0'], cwd=path)

#verify docker is installed
docker = subprocess.Popen(['docker','--version'], cwd=path)

if not docker:
	print ("Docker is not installed, https://docs.docker.com/v17.12/install/")

#build saltmaster image
cmd = "docker build -t saltmaster ."
subprocess.call(cmd, shell=True)

#start saltmaster
cmd = "docker run -v $LAB_HOME/hosts:/srv/hosts -v $LAB_HOME/saltstack/config/:/etc/salt/ -v $LAB_HOME/saltstack/file_root/:/srv -p 4505:4505 -p 4506:4506 -d --name saltmaster saltmaster /etc/salt/startup.sh"
subprocess.call(cmd, shell=True)

sys.exit(0)
