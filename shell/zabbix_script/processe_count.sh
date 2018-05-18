#!/bin/bash
# Application processes and thread number counst

# Get application pid value, get pid from application listen port
[[ $1 == thread ]] && PORT=$2 && PID=`netstat -lntp | grep -w ${PORT} | awk '{ print $NF }' \
    | awk -F "/" '{ print $1 }'`

# When $1 is thread, default TH value is $2,if $2 is null then TH is null
# The TH value is null, default get all process number
# If TH value is m, then get all thread in process number
[[ $1 == process ]] && TH=$2

# Get process or thread in process all
total_thread() {
    echo $((`ps aux${TH} | wc -l` - 3))
}

# Get thread in process
pro_thread() {
    echo $(grep Threads /proc/$PID/status | awk '{print $NF}')
}

case $1 in
    thread)
        pro_thread;
        ;;
    process)
        total_thread;
        ;;
esac
