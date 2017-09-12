#!/bin/bash
num=`grep -n -w "runv.sh" run.sh | grep -v "#" | awk -F: '{ print $1 }'`
if [ -n "$num" ]; then
       sed -i ${num}s/^/#/ run.sh
   fi

