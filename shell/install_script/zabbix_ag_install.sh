#!/bin/bash

sudo rpm -ivh https://repo.zabbix.com/zabbix/4.0/rhel/6/x86_64/zabbix-release-4.0-1.el6.noarch.rpm
sudo yum install -y zabbix-agent
sudo chkconfig zabbix-agent
sudo sed -i "s/# HostMetadata=/HostMetadata=Server/g" /etc/zabbix/zabbix_agentd.conf
