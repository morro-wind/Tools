#!/bin/bash

# Defined variable
BIN=`which aws`
INTERFACEID=""
FLOATIP=""


ps aux | grep while | grep -v grep

[[ $? == 0 ]]  && exit 0

while true
do
    netstat -lnt | grep 20080 | grep -v grep
    [[ $? != 0 ]] && $BIN ec2 assign-private-ip-addresses --allow-reassignment --network-interface-id $INTERFACEID --private-ip-addresses $FLOATIP
done
