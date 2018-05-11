#!/bin/bash
NUM=$1
user_time() {
    USER_TIME=$(mpstat -P $NUM | awk '{ print $3 }' | sed -n '$p')
    #echo USER_TIME
}
    echo "USER_TIME=$(mpstat -P $NUM | awk '{ print $3 }' | sed -n '$p')"
#echo $user
#nice
#system
#iowait
#irq
#soft
##steal
#guest
#gnice
#idle
