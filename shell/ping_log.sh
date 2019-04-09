#!/bin/bash
nohup ping -s 1000 -W 500 10.223.112.28 | perl -nle 'use Time::Piece; BEGIN
{$|++} print localtime->datetime, " ", "src:10.240.1.28 ", $_' >> ip28-`date
    +%F`.txt &

BIN=/usr/bin
DESTIP=
SRCIP=
LOGFILE=/tmp/$DESTIP-`date +%F`.log
TIMEOUT=
PACKETSIZE=
PID=

do_start() {
    nohup ping -s $PACKETSIZE -W $TIMEOUT $DESTIP | perl -nle \
        'use Time::Piece; BEGIN {$|++} print localtime->datetime, " ", "Src:$SRCIP ", $_' >> $LOGFILE & echo $! > $PID
}

do_stop() {
    [[ -f $PID ]] && kill `cat $PID`
}

case "$1" in
    start)
        do_start
        ;;
    stop)
        do_stop
        ;;
esac
