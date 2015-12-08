#!/bin/bash

set -x

exec &> >(tee -i /tmp/cloudinit.log 2>&1)

dbuser=$1
dbpass=$2

apt-get update

apt-get install python-software-properties

apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 0xcbcb082a1bb943db

add-apt-repository 'deb http://mirror.jmu.edu/pub/mariadb/repo/5.5/ubuntu trusty main'

apt-get update

export DEBIAN_FRONTEND=noninteractive


debconf-set-selections <<< "mariadb-server-10.0 mysql-server/root_password password $dbpass"

debconf-set-selections <<< "mariadb-server-10.0 mysql-server/root_password_again password $dbpass"

DEBIAN_FRONTEND=noninteractive apt-get install -y rsync galera mariadb-galera-server

mysql --user=root --password=rootpass -e "GRANT ALL PRIVILEGES ON *.* TO '$dbuser'@'10.0.0%' IDENTIFIED BY '$dbpass' WITH GRANT OPTION;"
mysql --user=root --password=rootpass -e "GRANT ALL PRIVILEGES ON *.* TO '$dbuser'@'%.%.%.%' IDENTIFIED BY '$dbpass' WITH GRANT OPTION;"

service mysql stop

wget https://raw.githubusercontent.com/keithtobin/mariadbclusterazure/master/MariaDBClusterOnAzure/conf/galera.cnf -O /etc/mysql/conf.d/galera.cnf

sleep 120

service mysql start

touch /tmp/cloudinit_was_run
