#!/bin/bash

BIN=ansible

[[ $# -eq 1 ]] && APP="$@"
echo $APP
for i in $@
do
    echo $i
done
[[ $# -ge 2 ]] && APP=$@ echo $APP
echo $APP
