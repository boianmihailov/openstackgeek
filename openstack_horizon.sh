#!/bin/bash

# Make sure only root can run our script
if [ "$(id -u)" != "0" ]; then
   echo "You need to be 'root', use sudo to run the script." 1>&2
   exit 1
fi

# get horizon
apt-get install -y libapache2-mod-wsgi openstack-dashboard

# restart apache
service apache2 restart
update-rc.d apache2 defaults


. ./stackrc
password=$SERVICE_PASSWORD
host_ip=$(/sbin/ifconfig eth0| sed -n 's/.*inet *addr:\([0-9\.]*\).*/\1/p')

echo "#######################################################################################"
echo "The horizon dashboard should be at http://$host_ip/.  Login with admin/$password"
echo "#######################################################################################"

