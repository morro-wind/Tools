#!/bin/bash
#
#
#
APP_NAME=APP
APP_HOME=/usr/mpsp
JAVA_HMOE=/usr/java/default
JAVA_EXE=${JAVA_HOME}/bin
CLASSPATH=

PIDFILE=/usr/mpsp/pid/${APP_NAME}.pid

case "$1" in
    start)
        if [ -f $PIDFILE ];then
            echo "$PIDFILE exists, process is already running or crashed"
        else
            echo "Starting ${APP_NAME} service..."
            $JAVA_EXE $APP_HOME
            echo $! > $PIDFILE
        fi
        ;;
    stop)
        if [ ! -f $PIDFILE ];then
            echo "$PIDFILE does not exist, process is not running"
        else
            PID=$(cat $PIDFILE)
            echo "Stopping..."
            kill -s QUIT $PID
            retval=$?
            echo
            [ $retval -eq 0 ] && rm -f $
        fi
esac
