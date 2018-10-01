#!/user/bin/env python3

import os, sys, subprocess, string

#start saltmaster
print("Starting VM saltmaster")
path = os.getcwd()+'/hosts/saltmaster'
cmd = 'vagrant up'
p = subprocess.Popen(['vagrant', 'up'], cwd=path)
