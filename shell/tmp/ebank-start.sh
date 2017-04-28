#!/bin/bash
#
#
FILE_HOME=
FILE_NAME=
for line in `cat $FILE_HOME/$FIEL_NAME`
do
    APP_HOME=`dirname $line`
    APP_SCRIPT=`basename $line`
    cd $APP_HOME
    if [ -f pid ];then
        #netstat -lntp | grep `cat pid`
        if [ -f runs ];then
            ./runs
            sleep 3
        fi

        if [ -f stop.sh ];then
            ./stop.sh
            sleep 3
        fi
    fi
    ./$APP_SCRIPT 2>/dev/null
done
