#!/bin/bash
user_time() {
    USER_TIME=`vmstat | awk '{ print $13 }' | sed -n '$p'`
    echo $USER_TIME
}

system_time() {
    SYSTEM_TIME=`vmstat | awk '{ print $14 }' | sed -n '$p'`
    echo $SYSTEM_TIME
}

idle_time() {
    IDLE_TIME=`vmstat | awk '{ print $15 }' | sed -n '$p'`
    echo $IDLE_TIME
}

iowait_time() {
    WAIT_TIME=`vmstat | awk '{ print $16 }' | sed -n '$p'`
    echo $WAIT_TIME
}

steal_time() {
    STEAL_TIME=$(vmstat | awk '{ print $17 }' | sed -n '$p')
    echo $STEAL_TIME
}

help_time() {
     echo "parameter in user | system | idle | iowait | steal"
     echo "-1"
 }

case $1 in
    user)
        user_time;
        ;;
    system)
        system_time;
        ;;
    idle)
        idle_time;
        ;;
    iowait)
        iowait_time;
        ;;
    steal)
        steal_time;
        ;;
    *)
        help_time;
        ;;
esac
