#!/bin/bash

for saltkey in $(ls /etc/salt/pki/master/minions)
  do
    if ! [[ $saltkey  == $(ls /srv/hosts | grep $saltkey) ]]
      then
        rm /etc/salt/pki/master/minions/$saltkey /etc/salt/keygen/${saltkey}.*
      fi
done
