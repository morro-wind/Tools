#/bin/bash
COUNT=$2
IP=$3

[[ $# != 3 ]] && echo "$0 args count ip" && exit 2
icmpping() {
    ping -c $COUNT $IP > /dev/null
    status=$?
    [[ $status != 0 ]] && exit 0
    [[ $status = 0 ]] && exit 1
}

icmploss() {
    ping $IP -c $COUNT | grep loss | awk -F% '{print $1}' | awk '{print $NF}'
}

icmptime() {
    ping $IP -c $COUNT | grep avg | awk -F / '{print $5}'
}

case $1 in
    ping)
        icmpping;
        ;;
    loss)
        icmploss;
        ;;
    time)
        icmptime;
        ;;
esac
