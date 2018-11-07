#!/user/bin/env python3

import os, sys, subprocess, string, shutil

#prompt for hostname, default will be box+4 random nums
hostname = str(raw_input("Hostname for VM to destroy: "))
if hostname is '':
    print("enter a hostname...")
    hostname = str(raw_input("Hostname for VM to destroy: "))
    if hostname is '':
        sys.exit(0)

#prompt for OS, default will be ubun
confirm = str(raw_input("Are you sure you want to destroy this VM?: "))

if confirm is 'yes' or 'y':
    print("Destroying VM "+hostname)
    path = os.getcwd()+'/hosts/'+hostname
    cmd = 'vagrant up'
    subprocess.call(['vagrant', 'destroy', '-f'], cwd=path)

    shutil.rmtree(path, ignore_errors=True)
else:
 sys.exit(0)
