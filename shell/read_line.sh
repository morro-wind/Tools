#!/bin/bash

[[ $# != 2 ]] && echo "$1 is template.ldif /n $2 is variable.template" && exit 1
while read line
do
    GROUP=`echo $line | awk '{ print $1 }'`
    NAME=`echo $line | awk '{ print $2 }'`
    USERID=`echo $line | awk '{ print $3 }'`
    EMAIL=`echo $line | awk '{ print $4 }'`
    PASSWD=${USERID}"123456&*()"
    sed -i "s/GROUP/$GROUP/;s/USERID/$USERID/;s/EMAIL/$EMAIL/" $1
    while read line
    do
        echo "$line"
    done < people.ldif
    sed -i "s/$GROUP/GROUP/;s/$USERID/USERID/;s/$EMAIL/EMAIL/" $1
done < $2

#case $1 in
#    help)
#        echo help
#        ;;
#    h)
#        echo h
#        ;;
#esac
