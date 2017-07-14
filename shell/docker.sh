#!/bin/bash
#docker service bin
BIN=/usr/bin/docker service

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

do_create() {
    $BIN create --name ${CONT_NAME} --update-delay $TIME --replicas ${NUM_NODE} \
        --mount type=bind,source=/usr/mpsp/spEnterprise,destination=/usr/mpsp/resin-4.0.48/conf/spEnterprise \
        --mount type=bind,source=/usr/mpsp/log,destination=/usr/mpsp/resin-4.0.48/log \
        --mount type=bind,source=/usr/mpsp/duizhang,destination=/usr/mpsp/duizhang \
        --mount type=bind,source=/AppData,destination=/AppData \
        --mount type=bind,source=/etc/localtime,destination=/etc/localtime \
        --mount type=bind,source=/usr/share/zoneinfo/Asia/Shanghai,destination=/usr/share/zoneinfo/Asia/Shanghai \
        --label traefik.port=$PORT --network ${NETWORK_NAME} --label traefik.backend.loadbalancer.sticky=true \
        $IMAGE
}

do_update() {
    $BIN update --update-delay 60s --image $IMAGE
}

do_scale() {
    $BIN scale ${APP_NAME}=$NUM_NODE
}

do_help() {
    echo "Usage: create|update|scale"
    exit 3
}

case $1 in
    create)
        [ $# -ne 3 ] && do_help
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
                [ $NODES -lt $NUM_NODE ] && NUM_NODE=$NODES
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
