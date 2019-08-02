#!/bin/bash

if [ $1 == "test" ]; then
    psdb=ps
    osdb=quick_os
elif [ $1 == "z" ]; then
    psdb=psz
    osdb=quick_osz
elif [ $1 == "j" ]; then
    psdb=psj8
    osdb=quick_osj
else
echo "error" && exit 1
fi

apppath=/opt/app
cd $apppath
for app in jobs pay
do
    if [ -d $app ]; then
        sed "/url/{s/ps.*$/$psdb/g}" $apppath/$app/conf/context.xml | grep url
        sed "/url/{s/quick_.*$/$osdb/g}" $apppath/$app/conf/context.xml | grep url
    fi
done
