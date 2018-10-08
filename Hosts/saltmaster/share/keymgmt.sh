#!/bin/bash

for saltkey in $(ls /etc/salt/pki/master/minions)
  do
    if ! [ $saltkey  == $(ls /srv/hosts | grep $saltkey) ]
      then
        echo $saltkey " will be deleted"
      fi
#    echo "outerloop: " $saltkey ${array[@]}
done
