#!/user/bin/env python3

import os, sys, subprocess, string

path = os.getcwd()

token = str(raw_input("enter your AppOptics token\n you can find a list of available tokens here: https://my.appoptics.com/organization/tokens :"))

vmconf = open("saltstack/pillar/hosts.sls", 'a')
vmconf.write("aotoken_env: "+token+"\n")

##verify vbox version

##verify docker version

print("Installing VBox Guest Additions")
p = subprocess.Popen(['vagrant', 'plugin', 'install', 'vagrant-vbguest'], cwd=path)

print("remove default VBox DHCP server")
p = subprocess.Popen(['VBoxManage', 'dhcpserver', 'remove', '--netname', 'HostInterfaceNetworking-vboxnet0'], cwd=path)

#start saltmaster
print("Starting VM saltmaster")
path = os.getcwd()+'/hosts/saltmaster'
cmd = 'vagrant up'
p = subprocess.Popen(['vagrant', 'up'], cwd=path)
