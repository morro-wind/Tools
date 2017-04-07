#!/bin/bash
#The script delete file on time

DELETE_HOME=/usr/log

find ${DELETE_HOME} -type f -mtime +7 -exec rm -f {} \;

echo $?
exit
