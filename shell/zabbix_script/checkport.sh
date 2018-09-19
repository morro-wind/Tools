#!/bin/bash

IP=$1
PORT=$2
nmap -Pn -p$2 $1 | grep $2 | awk '{print $2}'
