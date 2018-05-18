#!/bin/bash

# Protocol is $1, Value is 't' or 'u'
# STATUS is LISTEN, ESTABLISHED, SYN_SENT, SYN_RECV, FIN_WAIT1, FIN_WAIT2,
# TIME_WAIT, CLOSE, CLOSE_WAIT, LAST_ACK, LISTEN, CLOSING, UNKNOWN
# Default PROTOCOL
STATUS=
PRO=
[[ ! -z $1 ]] && STATUS=$1 && GREP=grep
[[ ! -z $2 ]] && PRO=$2

echo $(netstat -ano${PRO} | grep '$STATUS' | wc -l)
EXC='netstat -ano${PRO} | grep $STATUS | wc -l'
EXEC=netstat
ARG=ano
netstat_tcp_close() {
    $EXEC -${ARG}t
echo $($EXC)
