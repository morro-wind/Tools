#!/bin/bash
#
# start - this script starts and stops the application
#
# chkconfig:   - 85 15
#maintainer morro-wind mail address imorrowind#hotmail.com
#The script all application {start|stop|restart}

USER_HOME=/usr/mpsp

do_start()
{
    for i in `find $USER_HOME -path ${USER_HOME}/appBakeup -prune -o \
        -path ${USER_HOME}/shengchan_bak -prune -o \
        -path ${USER_HOME}/lazy -prune -o \
        -path ${USER_HOME}/yunxing -prune -o -name "serv.sh" -exec dirname {} \;`
    do
        cd $i
        sed -i '/^tail/s/^/#/' serv.sh
    	/bin/bash serv.sh 2>/dev/null
    done

    for i in `find ${USER_HOME}/ -path ${USER_HOME}/appBakeup -prune -o \
        -path ${USER_HOME}/shengchan_bak -prune -o \
        -path ${USER_HOME}/lazy -prune -o \
        -path ${USER_HOME}/yunxing -prune -o -name "run.sh" -exec dirname {} \;`
    do
        cd $i
        sed -i '/^tail/s/^/#/' run.sh

        [ -f runv.sh ] && sed -i '/^tail/s/^/#/' runv.sh
        [ -f runs ] && /bin/bash runs
          sleep 3
        [ -f stop.sh ] && /bin/bash stop.sh
          sleep 3
        /bin/bash run.sh 2>/dev/null
    done

    for i in `find ${USER_HOME}/run/ -regex ".*d$" -exec basename {} \;`
    do
        cd ${USER_HOME}/run
        ./$i 2>/dev/null
    done
}

do_stop()
{
    cd ${USER_HOME}
     for i in `find $USER_HOME -path ${USER_HOME}/appBakeup -prune -o \
         -path ${USER_HOME}/shengchan_bak -prune -o \
         -path ${USER_HOME}/lazy -prune -o \
         -path ${USER_HOME}/yunxing -prune -o -name "serv.sh" -exec dirname {} \;`
    do
        cd $i
        sed -i '/^tail/s/^/#/' unserv.sh
    	./unserv.sh 2>/dev/null
    done

    for i in `find ${USER_HOME}/ -path ${USER_HOME}/appBakeup -prune -o \
        -path ${USER_HOME}/shengchan_bak -prune -o \
        -path ${USER_HOME}/lazy -prune -o \
        -path ${USER_HOME}/yunxing -prune -o -name "run.sh" -exec dirname {} \;`
    do
        cd $i
        [ -f runv.sh ] && sed -i '/^tail/s/^/#/' runv.sh
        [ -f runs ] && /bin/bash runs
          sleep 3
        [ -f stop.sh ] && /bin/bash stop.sh
          sleep 3
    done

    for i in `find ${USER_HOME}/run/ -regex ".*s$" -exec basename {} \;`
    do
        cd ${USER_HOME}/run
        ./$i 2>/dev/null
    done
}

case "$1" in
    start)
        do_start
        ;;
    stop)
        do_stop
        ;;
    restart)
        do_stop
        do_start
        ;;
    *)
        echo "Usage: {start|stop|restart}" >&2
        exit 3
        ;;
esac
