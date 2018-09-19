#!/bin/env bash
# Version: autorun sql files 0.1
# MAINTAINER yinglie "1713931181@qq.com"
#set -x
# The shell that psql is to execute the given command string
# Environment dependence svn client and psql client

# Set language env
export LANG="zh_CN.UTF-8"
export LC_ALL="zh_CN.UTF-8"
# Modify path contains space issue
SAVE_IFS=$IFS
IFS='
'

# Set variable
DATE=$1
#[[ -z ${DATE} ]] && DATE=`date +%Y%m%d`
DATEP=`date +%Y%m%d`
DB_NAME=""
#BACK_PATH=""
SVN_PATH="/DATA/opt/runsql/sql"
#SVN_BIN=`which svn`
#SVN_USER=""
#SVN_PWD=""
#SVN_ADDR=""
#SVN_LOG="/DATA/opt/runsql/log/svn-${DATE}.log"
PSQL_LOG=""
PSQL_BIN=`which psql`
PSQL_HOST=""
PSQL_PORT=""
PSQL_USER=""
PSQL_PASSWD="p"
export PGPASSWORD=postgres

#if [ -d ${SVN_PATH} ]; then
#    svn info ${SVN_PATH}
#    [ $? -ne 0 ] && rm -rf ${SVN_PATH}

#if [ ! -d ${SVN_PATH} ]; then
#    svn co --username ${SVN_USER} --password "${SVN_PWD}" \
#        ${SVN_ADDR} ${SVN_PATH} >> ${SVN_LOG}
#else
#    svn up ${SVN_PATH} >> ${SVN_LOG}
#fi

# Getpath or filename
cd ${SVN_PATH}
#FIND="find ${SVN_PATH}/${DATE} -type f -iname *.sql"
#PSQ_EXEC="${PSQL_BIN} -h ${PSQL_HOST} -p ${PSQL_PORT} -U ${PSQL_USER} -L ${LOG_PATH} -d ${DB_NAME} -f ${FILE_NAME}"

[[ ! -d "${SVN_PATH}/${DATE}" ]] && echo "${DATE} days documents do not exist."
    # backup sql

for SQLIST in `find ${SVN_PATH}/${DATE} -type f -mmin -55 -iname "*.sql"`
do
    START=`grep -n "/\*" ${SQLIST} | head -n 1 | awk -F ":" '{ print $1 }'`

    if [ -z ${START} ]; then
        SCHEMA_NAME=`sed "s///g;s/^ //g" ${SQLIST} | grep -Ev "^--|^$" | awk -F '.' '{ print $1 }' | awk '{ print $NF }' | head -n 1 | sed 's/"//g'`
    else
        END=`grep -n "\*/" ${SQLIST} | head -n 1 | awk -F ":" '{ print $1 }'`
        SCHEMA_NAME=`sed "${START},${END}d;s///g;s/^ //g" ${SQLIST} | grep -Ev "^--|^$|/\*|^" | awk -F '.' '{ print $1 }' | awk '{ print $NF }' | head -n 1 | sed 's/"//g'`
    fi
    #DB_NAME=`grep -Ev "^--|^$" ${SQLIST} | awk -F '.' '{ print $1 }' | awk \
    #        '{ print $NF }' | head -n 1 | sed 's/"//g'`
    case ${SCHEMA_NAME} in
        a|j|n|r)
            DB_NAME="dbname1"
            ;;
        ac|c|e|h|i|p|pu|*)
            DB_NAME="dbname2"
            ;;
    esac
    FILE_NAME=`basename $SQLIST`
    echo "dataname=${DB_NAME}"
    echo "filename=${SQLIST}"
    cd $(dirname $SQLIST)
    ${PSQL_BIN} -h ${PSQL_HOST} -p ${PSQL_PORT} -U ${PSQL_USER} -d ${DB_NAME} -f ${FILE_NAME} -L ${PSQL_LOG}
done
[[ -f ${PSQL_LOG} ]] && cat ${PSQL_LOG}
IFS=${SAVE_IFS}
exit 0
