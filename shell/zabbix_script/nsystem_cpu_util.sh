#!/bin/bash
CPU_PRO=$2
NUM=$(cat /proc/cpuinfo |grep "processor"|wc -l)

#expr $CPU_PRO + 0 &> /dev/null && [[ $(echo $?) -eq 0 ]] && [[ $CPU_PRO -lt $NUM ]] && CPU_TIME=$(mpstat -P $CPU_PRO | sed -n '$p')
#[[ $CPU_PRO != "ALL" ]] && exit -1
[[ $CPU_PRO != "ALL" ]] && [[ $CPU_PRO -lt $NUM ]] && CPU_TIME=$(mpstat -P $CPU_PRO | sed -n '$p')
[[ $CPU_PRO = "ALL" ]] && CPU_TIME=$(mpstat | sed -n '$p')

user_time() {
    echo $(echo $CPU_TIME | awk '{ print $3 }')
}

nice_time() {
    echo $(echo $CPU_TIME | awk '{ print $4 }')
}

system_time() {
    echo $(echo $CPU_TIME | awk '{ print $5 }')
}

iowait_time() {
    echo $(echo $CPU_TIME | awk '{ print $6 }')
}

irq_time() {
    echo $(echo $CPU_TIME | awk '{ print $7 }')
}

soft_time() {
    echo $(echo $CPU_TIME | awk '{ print $8 }')
}

steal_time() {
    echo $(echo $CPU_TIME | awk '{ print $9 }')
}

guest_time() {
    echo $(echo $CPU_TIME | awk '{ print $10 }')
}

gnice_time() {
    echo $(echo $CPU_TIME | awk '{ print $11 }')
}

idle_time() {
    echo $(echo $CPU_TIME | awk '{ print $12 }')
}

case $1 in
    user)
        user_time;
        ;;
    nice)
        nice_time;
        ;;
    system)
        system_time;
        ;;
    iowait)
        iowait_time;
        ;;
    irq)
        irq_time;
        ;;
    soft)
        soft_time;
        ;;
    steal)
        steal_time;
        ;;
    guest)
        guest_time;
        ;;
    gnice)
        gnice_time;
        ;;
    idle)
        idle_time;
        ;;
esac
[[ -z $CPU_TIME ]] && echo -1
