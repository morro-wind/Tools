#!/bin/bash

#maintainer morro-wind mail address imorrowind#hotmail.com
#The script all application {start|stop|restart}

USER_HOME=/usr/mpsp

cd $USER_HOME

do_start()
{
    for i in `find ./ -path ./appBakeup -prune -o -path ./shengchan_bak -prune -path ./lazy -prune -path ./yunxing -prune -o -name "serv.sh" -exec dirname {} \;`
    do
        cd ${USER_HOME}/$i
        sed -i '/^tail/s/^/#/' serv.sh
    	./serv.sh 2>/dev/null
    done

    for i in `find ./ -path ./appBakeup -prune -o -path ./shengchan_bak -prune -path ./lazy -prune -path ./yunxing -prune -o -name "run.sh" -exec dirname {} \;`
    do
        cd ${USER_HOME}/$i
        sed -i '/^tail/s/^/#/' run.sh
        ./run.sh 2>/dev/null
    done

    for i in `find ${USER_HOME}/run/ -regex ".*d$" -exec basename {} \;`
    do
        cd ${USER_HOME}/run
        ./$i 2>/dev/null
    done
}

do_stop()
{
    for i in `find ./ -path ./appBakeup -prune -o -path ./shengchan_bak -prune -path ./lazy -prune -path ./yunxing -prune -o -name "serv.sh" -exec dirname {} \;`
    do
        cd ${USER_HOME}/$i
        ./unserv.sh 2>/dev/null
    done

    for i in `find ./ -path ./appBakeup -prune -o -path ./shengchan_bak -prune -path ./lazy -prune -path ./yunxing -prune -o -name "run.sh" -exec dirname {} \;`
    do
        cd ${USER_HOME}/$i
        ./runs 2>/dev/null
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
