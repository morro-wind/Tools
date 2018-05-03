#!/bin/bash

[[ $# != 2 ]] && echo "$1 is template.ldif /n $2 is variable.template" && exit 1
while read line
do
    GROUP=`echo $line | awk '{ print $1 }'`
    NAME=`echo $line | awk '{ print $2 }'`
    USERID=`echo $line | awk '{ print $3 }'`
    EMAIL=`echo $line | awk '{ print $4 }'`
    PASSWD=`/DATA/opt/openldap/sbin//slappasswd -s ${USERID}"!123"`
    SNAME=`echo ${NAME:0:1}`
    CNAME=`echo ${NAME:1}`
    sed "s/GROUP/$GROUP/;s/USERID/$USERID/;s/EMAIL/$EMAIL/; \
        s/SNAME/$SNAME/;s/CNAME/$CNAME/;s#PASSWD#$PASSWD#" $1 >> new_$1
    #while read line
    #do
    #    echo "$line" >> template_new.ldif
    #done < $1
    #sed -i "s/$GROUP/GROUP/;s/$USERID/USERID/;s/$EMAIL/EMAIL/; \
    #    s/$SNAME/SNAME/;s/$CNAME/CNAME/;s/$PASSWD/PASSWD/" $1
done < $2

#case $1 in
#    help)
#        echo help
#        ;;
#    h)
#        echo h
#        ;;
#esac
