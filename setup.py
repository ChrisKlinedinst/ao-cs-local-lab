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

##verify docker version
#docker = subprocess.Popen(['VBoxManage','--version'], cwd=path)

##prompt for saltmaster as container
#if not docker:
#    saltdocker = str(raw_input("By default the saltmaster is installed as a VM, would you like to run it as a docker container instead?"))

#if saltdocker is 'no' or 'n':
#    #start saltmaster as VM
#    print("Starting VM saltmaster")
#    path = os.getcwd()+'/hosts/saltmaster'
#    cmd = 'vagrant up'
#    p = subprocess.Popen(['vagrant', 'up'], cwd=path)

#elif saltdocker is 'yes' or 'y'

sys.exit(0)
