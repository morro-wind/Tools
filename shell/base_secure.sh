#!/bin/bash
if [ -f /etc/ssh/sshd_config ];then
    if [[ ! `grep -w "PermitRootLogin no" /etc/ssh/sshd_config 2>/dev/null` ]];then
        sed -i "s/^#PermitRootLogin yes/PermitRootLogin no/g" /etc/ssh/sshd_config

