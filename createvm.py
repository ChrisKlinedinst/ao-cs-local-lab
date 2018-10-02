#!/user/bin/env python3
import os, sys, subprocess, string
from random import randint

path = os.getcwd()

#prompt for OS, default will be ubun
box = str(raw_input("Vagrant Box Name \n ex: ubuntu, centos, ubuntu/trusty64: "))
if box is '':
    box = 'ubuntu/trusty64'
    print('building with Ubuntu 14.04')

elif box == 'ubuntu':
        box = 'ubuntu/xenial64'
        print('building with Ubuntu 16.04')

elif box == 'centos':
    box = 'centos/7'
    print('building with Centos 7 Minmal')

#prompt for hostname, default will be box+4 random nums
hostname = str(raw_input("Hostname for VM: "))
if hostname is '':
    hostname = 'lab-'+box[:6]+'-'+str(randint(0, 999))
    print('Hostname will be '+hostname)


#prompt for memory sepc, default will be 512
memory = int(raw_input("MB of Memory for VM: "))

#show summary
print(box+" will be installed on "+hostname+" with "+str(memory)+"MB of memory")

#need a check to see if saltmater is listening

#create dir in hosts

path= "hosts/"+hostname
print('VM will be built in ' + path)

#apply file permissions
access_rights = 0o755

try:
    os.mkdir(path, access_rights)
except OSError:
    print ('unable to create dir at '  + str(path) + ' the dir may already exist...')

try:
    os.mkdir(path+'/share', access_rights)
except OSError:
    print ('unable to create dir at '  + str(path) + ' the dir may already exist...')

try:
    os.makedirs(path+'/keys/salt', access_rights)
except OSError:
    print ('unable to create dir at '  + str(path) + ' the dir may already exist...')

#populate vagrantfile using variables

vmconf = open("hosts/"+hostname+"/Vagrantfile", 'a')

vmconf.write('Vagrant.configure("2") do |config|\n')
vmconf.write('  #Vagrant Image to use\n')
vmconf.write('  config.vm.box = "'+box+'"\n')
vmconf.write('  #hostname for vm\n')
vmconf.write('  config.vm.hostname = "'+hostname+'"\n')
vmconf.write('  #network configuration\n')
vmconf.write('  config.vm.network "private_network", type: "dhcp"\n')

#map salt share
vmconf.write('  #map local shares\n')
vmconf.write('  config.vm.synced_folder "../../salt/states/pillar", "/srv/salt"\n')

#map local share
vmconf.write('  config.vm.synced_folder "share", "/srv/share"\n')

#enable networking on centos

if 'centos' in box:
    vmconf.write('  #enable networking on centos minimal distros\n  config.vm.provision "shell", inline: <<-SHELL\n    sudo systemctl enable NetworkManager\n    sudo systemctl start NetworkManager\n  SHELL\n')

#add Virtual Box config lines
vmconf.write('  #virtualbox configuration\n')
vmconf.write('  config.vm.provider "virtualbox" do |vb|\n    vb.gui = true\n    vb.name="'+hostname+'"\n    vb.memory = "'+str(memory)+'"\nend\n')

#configure salt
vmconf.write('  #salt configuration\n')
vmconf.write('  config.vm.provision :salt do |salt|\n  salt.install_type = "stable"\n  salt.verbose = true\n  salt.colorize = true\n')

#generate salt keys
print("Creating Salt Keys")
path = os.getcwd()+'/hosts/saltmaster'
cmd = "vagrant ssh -c 'sudo salt-key --gen-keys="+hostname+" --gen-keys-dir=/srv/hosts/"+hostname+"/keys/salt/ && sudo cp -p /srv/hosts/"+hostname+"/keys/salt/"+hostname+".pub /etc/salt/pki/master/minions/"+hostname+"'"
subprocess.call('cd '+path+' && '+cmd, shell=True)
os.chmod("hosts/"+hostname+"/keys/salt/"+hostname+".pem", 0o644)
#cmd = "vagrant ssh -c 'sudo cp --no-preserve=662 /srv/hosts/"+hostname+"/keys/salt/"+hostname+".pub /etc/salt/pki/master/minions/"+hostname+".pub'"
#subprocess.call('cd '+path+' && '+cmd, shell=True)

#import salt keys
vmconf.write('  salt.minion_config = "../../salt/config/minion"\n')
vmconf.write('  salt.minion_id = "'+hostname+'"\n')
vmconf.write('  salt.minion_key = "keys/salt/'+hostname+'.pem"\n')
vmconf.write('  salt.minion_pub = "keys/salt/'+hostname+'.pub"\n')
vmconf.write('  salt.run_highstate = true\n')

vmconf.write('end\n config.vm.post_up_message = "press enter to complete setup..."\nend')

#start vm
print("Starting VM "+hostname)
path = os.getcwd()+'/hosts/'+hostname
cmd = 'vagrant up'
p = subprocess.Popen(['vagrant', 'up'], cwd=path)

sys.exit(0)
