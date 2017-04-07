#!/bin/bash

for i in `find ./ -path ./appBakeup -prune -o -path ./shengchan_bak -prune -path ./lazy -prune -o -name "serv.sh" -exec dirname {} \;`
do
    cd /usr/mpsp
	cd $i
    sed -i '/^tail/s/^/#/' serv.sh
	./serv.sh
done

for i in `find ./ -path ./appBakeup -prune -o -path ./shengchan_bak -prune -path ./lazy -prune -o -name "run.sh" -exec dirname {} \;`
do
    cd /usr/mpsp
    cd $i
    sed -i '/^tail/s/^/#/' run.sh
    ./run.sh
done
