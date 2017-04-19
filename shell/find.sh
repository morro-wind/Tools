
#!/bin/bash
USER_HOME=/usr/mpsp


    for i in `find $USER_HOME -path ${USER_HOME}/lost+found -prune -o -path ${USER_HOME}/appBakeup -prune -o -path \
        ${USER_HOME}/shengchan_bak -prune -o -path ${USER_HOME}/lazy -prune -path \
        ${USER_HOME}/yunxing -prune -o -name "serv.sh" -exec dirname {} \;`
do
    echo $i
    ls $i
    grep "Dflag\|SERVICE_ID\|SERVICE_NAME" $i/serv.sh
    #if [ -f appenv ]; then
    #grep "Dflag|SERVICE_ID" appenv
#fi
done

#if ;then
#    for i in 1
#    do
#        ls
#    done
#fi

    for i in `find ${USER_HOME}/ -path ${USER_HOME}/lost+found -prune -o -path ${USER_HOME}/appBakeup -prune -o -path \
        ${USER_HOME}/shengchan_bak -prune -o -path ${USER_HOME}/lazy -prune -o -path \
        ${USER_HOME}/yunxing -prune -o -name "run.sh" -exec dirname {} \;`
do
    echo -e "ls dirname:$i \n"
    ls $i

    if [ -f "$i/appenv" ];then
        echo -e "cat $i/appenv: \n"
        cat "$i/appenv"
    fi
    echo -e "grep $i \n"
    grep "Dflag\|SERVICE_ID\|SERVICE_NAME" $i/run.sh
#    grep "Dflag|SERVICE_ID" appenv
done

if [ -d "${USER_HMOE}/run" ];then
    for i in `find ${USER_HOME}/run/ -regex ".*d$" -exec basename {} \;`
    do
        ls ${USER_HOME}/run/$i
        grep "Dflag\|SERVICE_ID\|SERVICE_NAME" ${USER_HOME}/run/$i
    done
fi
