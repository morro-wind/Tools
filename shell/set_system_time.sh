#!/bin/bash
# https://superuser.com/questions/307158/how-to-use-ntpdate-behind-a-proxy
date -u --set="$(curl -H 'Cache-Control: no-cache' -sD - http://baidu.com |grep '^Date:' |cut -d' ' -f3-6)"
