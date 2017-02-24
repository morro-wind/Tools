#/bin/bash
#set -n
#set -x
dir=/tmp/log
if [ ! -d /tmp/log ];then
  mkdir $dir
fi
cd $dir
for i in ESoopay_CBE fx_plat2-pbg fx_routePaygate CBE_Merchant_API cbJobSystem
do
   if [ ! -d $i ];then
     mkdir $i
   else
     echo "$i already exist"
   fi
done
echo $?
