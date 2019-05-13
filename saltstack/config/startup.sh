#!/bin/bash

#create cron job for keymgmt
(crontab -l 2>/dev/null; echo "*/10 * * * * /etc/salt/keymgmt.sh") | crontab -

#start salt master
./usr/bin/salt-master