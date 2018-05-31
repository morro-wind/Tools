#!/bin/bash

# Protocol is $1, Value is 't' or 'u'
# STATUS is LISTEN, ESTABLISHED, SYN_SENT, SYN_RECV, FIN_WAIT1, FIN_WAIT2,
# TIME_WAIT, CLOSE, CLOSE_WAIT, LAST_ACK, LISTEN, CLOSING, UNKNOWN
# Default PROTOCOL
#STATUS=
#typeset -u STATUS
#STATUS=$(echo $1 | awk -F _ '{ print $NF }' | tr 'a-z' 'A-Z');
#PRO=
#[[ ! -z $1 ]] && STATUS=$1 && GREP=grep
#[[ ! -z $2 ]] && PRO=$2

#echo $(netstat -ano${PRO} | grep '$STATUS' | wc -l)
#EXC='netstat -ano${PRO} | grep $STATUS | wc -l'
[[ ! -z $2 ]] && GARGS=-w && PRO=$2
EXEC=netstat
ARGS=ano

netstat_tcp_listen() {
    echo $($EXEC -${ARGS}t | grep LISTEN | grep $GARGS "$PRO" | wc -l)
}

netstat_tcp_established() {
    echo `$EXEC -${ARGS}t | grep ESTABLISHED | grep $GARGS "$PRO" | wc -l`
}

netstat_tcp_close() {
    echo $($EXEC -${ARGS}t | grep CLOSE | grep $GARGS "$PRO" | wc -l)
}

netstat_tcp_closewait() {
    echo $($EXEC -${ARGS}t | grep CLOSE_WAIT | grep $GARGS "$PRO" | wc -l)
}

netstat_tcp_closing() {
    echo $($EXEC -${ARGS}t | grep -w CLOSING | grep $GARGS "$PRO" | wc -l)
}

netstat_tcp_fin_wait1() {
    echo $($EXEC -${ARGS}t | grep -w FIN_WAIT1 | grep $GARGS "$PRO" | wc -l)
}

netstat_tcp_fin_wait2() {
    echo $($EXEC -${ARGS}t | grep -w FIN_WAIT2 | grep $GARGS "$PRO" | wc -l)
}

netstat_tcp_last_ack() {
    echo $($EXEC -${ARGS}t | grep -w LAST_ACK | grep $GARGS "$PRO" | wc -l)
}

netstat_tcp_none() {
    echo $($EXEC -${ARGS}t | wc -l )
}

netstat_tcp_syn_sent() {
    echo $($EXEC -${ARGS}t | grep -w SYN_SENT | grep $GARGS "$PRO" | wc -l)
}

netstat_tcp_syn_recv() {
    echo $($EXEC -${ARGS}t | grep -w SYN_RECV | grep $GARGS "$PRO" | wc -l)
}

netstat_tcp_timewait() {
    echo $($EXEC -${ARGS}t | grep TIME_WAIT | grep $GARGS "$PRO" | wc -l)
}

netstat_udp_socket() {
    echo $($EXEC -${ARGS}u | grep SOCKET | wc -l)
}

case $1 in
    listen)
        netstat_tcp_listen;
        ;;
    established)
        netstat_tcp_established;
        ;;
    close)
        netstat_tcp_close;
        ;;
    close_wait)
        netstat_tcp_closewait;
        ;;
    closing)
        netstat_tcp_closing;
        ;;
    fin_wait1)
        netstat_tcp_fin_wait1;
        ;;
    fin_wait2)
        netstat_tcp_fin_wait2;
        ;;
    last_ack)
        netstat_tcp_last_ack;
        ;;
    none)
        netstat_tcp_none;
        ;;
    syn_sent)
        netstat_tcp_syn_sent;
        ;;
    syn_recv)
        netstat_tcp_syn_recv;
        ;;
    time_wait)
        netstat_tcp_timewait;
        ;;
    socket)
        netstat_udp_socket;
        ;;
esac
