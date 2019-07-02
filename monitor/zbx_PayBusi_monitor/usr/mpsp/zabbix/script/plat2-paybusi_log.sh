#!/bin/bash
a=`/usr/mpsp/zabbix/script/plat2-paybusi_log/script/scan_nrpe_log.pl /usr/mpsp/zabbix/script/plat2-paybusi_log/config`
if [[ $a =~ "OK" ]]
then
   echo "ok"
   else
   echo $a
fi
