#!/bin/bash
#docker service bin
BIN="/usr/bin/docker service"

#Container name
CONT_NAME=spenterpriseweb

#Count docker node number
NUM_NODE=`docker node ls | wc -l`
NUM_NODE=$[NUM_NODE-1]

#Container application port, default 8080
PORT=8080

#Container with network mode name,default over0
NETWORK_NAME=over0

#Delay time, default 60s
TIME=60s

SOUR_HOME="/usr/mpsp"
SOUR_SP="${SOUR_HOME}/spEnterprise/"
SOUR_LOG="${SOUR_HOME}/log/"
SOUR_DZ="${SOUR_HOME}/duizhang/"
SOUR_DAT="/AppData/"
SOUR_TIME="/etc/localtime"
SOUR_ZONE="/usr/share/zoneinfo/Asia/Shanghai"

do_create() {
    [ ! -d ${SOUR_SP} ] && echo "${SOUR_SP}:No such file or directory" && exit 1
    [ ! -d ${SOUR_LOG} ] && echo "${SOUR_LOG}:No such file or directory" && exit 1
    [ ! -d ${SOUR_DZ} ] && echo "${SOUR_DZ}:No such file or directory" && exit 1
    [ ! -d ${SOUR_DAT} ] && echo "${SOUR_DAT}:No such file or directory" && exit 1
    [ ! -f ${SOUR_TIME} ] && echo "${SOUR_TIME}:No such file or directory" && exit 1
    [ ! -f ${SOUR_ZONE} ] && echo "${SOUR_ZONE}:No such file or directory" && exit 1

    $BIN create --name ${CONT_NAME} --update-delay $TIME --replicas ${NUM_NODE} \
        --mount type=bind,source=${SOUR_SP},destination=/usr/mpsp/resin-4.0.48/conf/spEnterprise \
        --mount type=bind,source=${SOUR_LOG},destination=/usr/mpsp/resin-4.0.48/log \
        --mount type=bind,source=${SOUR_DZ},destination=/usr/mpsp/duizhang \
        --mount type=bind,source=${SOUR_DAT},destination=/AppData \
        --mount type=bind,source=${SOUR_TIME},destination=/etc/localtime \
        --mount type=bind,source=${SOUR_ZONE},destination=/usr/share/zoneinfo/Asia/Shanghai \
        --label traefik.port=$PORT --network ${NETWORK_NAME} --label traefik.backend.loadbalancer.sticky=true \
        $IMAGE
}

do_update() {
    $BIN update --update-delay $TIME --image $IMAGE
}

do_scale() {
    $BIN scale ${CONT_NAME}=$NUM_NODE
}

do_help() {
    echo "Usage: docker.sh ( commands ...)"
    echo "commands:"

    echo "  create {port network image} | {network image} | image      \n
             port default $PORT, network default $NETWORK_NAME"
    echo "  update [times] image        times default $TIME"
    echo "  scale numbers       scale numbers default $NUM_MODE"
    exit 3
}

case $1 in
    create)
        if [ $# -eq 4 ]; then
            PORT=$2
            NETWORK_NAME=$3
            IMAGE=$4
        elif [ $# -eq 3 ]; then
            NETWORK_NAME=$2
            IMAGE=$3
        elif [ $# -eq 2 ]; then
            IMAGE=$2
        else
            do_help
        fi
        do_create
        ;;
    update)
        if [ $# -eq 3 ]; then
            TIME=$2
            IMAGE=$3
        elif [ $# -eq 2 ]; then
            IMAGE=$2
        else
            do_help
        fi
        do_update
        ;;
    scale)
        if [ $# -lt 3 ]; then
            if [ $# -eq 2 ]; then
                NODES=$2
                if [ $NODES -lt $NUM_NODE ]; then
                    NUM_NODE=$NODES
                else
                    echo "container number error"
                    exit 2
                fi
            fi
        else
            do_help
        fi
        do_scale
        ;;
    *|help|-h|--help)
        do_help
        ;;
esac
