#!/bin/env bash
# Version: 0.1
# AUTHOR && MAINTAINER morrowind
# Replace the matched string line string
# set -x

# Lookup line character
LOOKUP="^Hostname"
# Matching character
#HOSTIP=`ifconfig eth0 | grep "inet addr" | awk -F ":" '{ print $2 }' | tr -d "addr:"`
HOSTIP=`ip addr show eth0 | grep -v inet6 | grep inet | awk '{ print $2 }'\
    | awk -F "/" '{ print $1 }'`
SRC="Zabbix server"
DEST="${HOSTIP}"
FILE="/DATA/opt/zabbix_agents/etc/zabbix_agentd.conf"

[[ -f ${FILE} ]] && sed -i "/${LOOKUP}/{s/$SRC/$DEST/g}" ${FILE}
[[ $? != 0 ]] && echo "COMMOND ERROR"
