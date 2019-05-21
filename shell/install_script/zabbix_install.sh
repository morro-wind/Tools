#!/bin/bash
sudo service iptables stop
sudo setenforce 0
sudo yum update -y
sudo yum upgrade -y
rpm -ivh https://repo.zabbix.com/zabbix/4.0/rhel/6/x86_64/zabbix-release-4.0-1.el6.noarch.rpm

sudo yum install zabbix-server-mysql -y
sudo yum install zabbix-web-mysql -y
sudo yum install zabbix-agent -y
sudo chkconfig zabbix-server on
sudo chkconfig zabbix-agent on
