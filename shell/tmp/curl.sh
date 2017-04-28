#!/bin/bash
set -x
#while [[ $status = 200 ]]
#do
#    curl -I http://uat.soopay.net/spay/pay/payservice.do
#    status = `curl -sL -w "%{http_code}" "uat.soopay.net/spay/pay/payservice.do"
#    -o /dev/null`
#done
i=0
while :
do
    #curl -I http://uat.soopay.net/spay/pay/payservice.do

    status=`curl -sL -w "%{http_code}" "10.10.173.89:8081/spay/pay/payservice.do" \
    -o /dev/null`
    ((i++))
    echo $i
    if [ $status -ne 200 ]
    then
        break
    fi
done
