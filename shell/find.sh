
#!/bin/bash
USER_HOME=/usr/mpsp


for i in `find $USER_HOME -path ${USER_HOME}/lost+found -prune -o \
    -path ${USER_HOME}/appBakeup -prune -o \
    -path ${USER_HOME}/shengchan_bak -prune -o \
    -path ${USER_HOME}/lazy -prune -o \
    -path ${USER_HOME}/yunxing -prune -o \
    -path ${USER_HOME}/mpsp -prune -o \
    -name "serv.sh" -exec dirname {} \;`
do
    echo -e "\n"
    echo -e "ls dirname:$i"
    ls $i

    echo -e "\n"
    if [ -f "$i/para" ];then
        echo -e "cat $i/para:"
        cat "$i/para"
    elif [ -f "$i/appenv"];then
        echo -e "cat $i/appenv:"
        cat "$i/appenv"
    fi

    echo -e "\n"
    echo -e "grep $i"
    grep "Dflag\|SERVICE_ID\|SERVICE_NAME\|APP_NAME" $i/serv.sh
    #if [ -f appenv ]; then
    #grep "Dflag|SERVICE_ID" appenv
#fi
done

echo -e "\n\n"
#if ;then
#    for i in 1
#    do
#        ls
#    done
#fi

for i in `find ${USER_HOME}/ -path ${USER_HOME}/lost+found -prune -o \
    -path ${USER_HOME}/appBakeup -prune -o \
    -path ${USER_HOME}/shengchan_bak -prune -o \
    -path ${USER_HOME}/lazy -prune -o \
    -path ${USER_HOME}/yunxing -prune -o \
    -path ${USER_HOME}/mpsp -prune -o \
    -name "run.sh" -exec dirname {} \;`
do
    echo -e "\n"
    echo -e "ls dirname:$i"
    ls $i

    echo -e "\n"
    if [ -f "$i/para" ];then
        echo -e "cat $i/para:"
        cat "$i/para"
    elif [ -f "$i/appenv" ];then
        echo -e "cat $i/appenv:"
        cat "$i/appenv"
    fi

    echo -e "\n"
    echo -e "grep $i"
    grep "Dflag\|SERVICE_ID\|SERVICE_NAME\|APP_NAME" $i/run.sh
done


echo -e "\n\n"

if [ -d "${USER_HMOE}/run" ];then
    for i in `find ${USER_HOME}/run/ -regex ".*d$" -exec basename {} \;`
    do
        ls ${USER_HOME}/run/$i
        grep "Dflag\|SERVICE_ID\|SERVICE_NAME\|APP_NAME" ${USER_HOME}/run/$i
    done
fi
