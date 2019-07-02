#!/bin/bash
#set -x
IP=`/sbin/ip addr show eth0 | grep -w inet | awk -F / '{print $1}' | awk '{print
$NF}'`

#sudo sed -i "/^Hostname/{s/Zabbix server/$IP/g}" /etc/zabbix/zabbix_agentd.conf
#sudo sed -i '/^HostMetadata/{s/SpecialLine/AWSThirdpart/g}'
/etc/zabbix/zabbix_agentd.conf
sudo sed -i "s/^Hostname.*$/Hostname=$IP/g" /etc/zabbix/zabbix_agentd.conf
#sudo sed -i "s/^HostMetadata.*$/HostMetadata=AWSET/g"
/etc/zabbix/zabbix_agentd.conf
grep "Hostname\|HostMetadata" /etc/zabbix/zabbix_agentd.conf
echo $IP

