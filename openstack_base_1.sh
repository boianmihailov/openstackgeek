#!/bin/bash

# Make sure only root can run our script
if [ "$(id -u)" != "0" ]; then
   echo "You need to be 'root', use sudo to run the script." 1>&2
   exit 1
fi

# install time server
apt-get install -y ntp
service ntp restart
update-rc.d ntp defaults

# modify timeserver configuration
sed -e "
/^server ntp.ubuntu.com/i server 127.127.1.0
/^server ntp.ubuntu.com/i fudge 127.127.1.0 stratum 10
/^server ntp.ubuntu.com/s/^.*$/server ntp.ubutu.com iburst/;
" -i /etc/ntp.conf

# install tgt
apt-get install -y tgt
service tgt start
update-rc.d tgt defaults

# openiscsi-client
apt-get install -y open-iscsi open-iscsi-utils

# turn on forwarding
echo 1 > /proc/sys/net/ipv4/ip_forward
echo "net.ipv4.ip_forward = 1" > /etc/sysctl.d/01-ip-forward.conf

echo "#################################################################################################
Go edit your /etc/network/interfaces file to look something like this:

auto eth0 
iface eth0 inet static
 address 10.0.1.20
 network 10.0.1.0
 netmask 255.255.255.0
 broadcast 10.0.1.255
 gateway 10.0.1.1
 dns-nameservers 8.8.8.8



After you are done, do a '/etc/init.d/networking restart', then run './openstack_base_2.sh'

#################################################################################################
"


exit
