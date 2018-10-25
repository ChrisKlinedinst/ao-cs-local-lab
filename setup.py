#!/user/bin/env python3

import os, sys, subprocess, string

path = os.getcwd()

token = str(raw_input("enter your AppOptics token\n you can find a list of available tokens here: https://my.appoptics.com/organization/tokens :"))

vmconf = open("saltstack/file_root/pillar/hosts.sls", 'a')
vmconf.write("aotoken_env: "+token+"\n")

##verify vbox version
vbox = subprocess.Popen(['VBoxManage','--version'], cwd=path)

if not vbox:
    print ("Virtualbox is not installed")

elif vbox:
    print("Installing VBox Guest Additions")
    p = subprocess.Popen(['vagrant', 'plugin', 'install', 'vagrant-vbguest'], cwd=path)
    print("remove default VBox DHCP server")
    p = subprocess.Popen(['VBoxManage', 'dhcpserver', 'remove', '--netname', 'HostInterfaceNetworking-vboxnet0'], cwd=path)

#start saltmaster
path = os.getcwd()+'/hosts/saltmaster'
cmd = "vagrant up"
subprocess.call('cd '+path+' && '+cmd, shell=True)

sys.exit(0)
