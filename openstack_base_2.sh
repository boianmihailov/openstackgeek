#!/bin/bash

# Make sure only root can run our script
if [ "$(id -u)" != "0" ]; then
   echo "You need to be 'root', use sudo to run the script." 1>&2
   exit 1
fi

# bridge stuff
apt-get install -y bridge-utils

# rabbit food
apt-get install -y rabbitmq-server memcached python-memcache

# kvm
apt-get install -y kvm libvirt-bin

echo "#################################################################################################
You'll need a LVM for 'nova-volumes'.  This assumes you have an empty disk spinning at /dev/sdb:

fdisk /dev/sdb

Create a new partition by hitting 'n' then 'p'.  Use the defaults.  Type 't' then '8e' to set the 
partition to the LVM type.  Hit 'w' to write and exit.

Next, do a:

pvcreate -ff /dev/sdb1
vgcreate nova-volumes /dev/sdb1

NOTE: You should use whatever device handle your system has.  Be careful!

When you are done, run './openstack_mysql.sh'

#################################################################################################
"
exit
