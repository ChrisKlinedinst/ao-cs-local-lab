#!/bin/bash

#create cron job for keymgmt
mv /etc/salt/keymgmt.sh /etc/cron.hourly/keymgmt

#start salt master
./usr/bin/salt-master