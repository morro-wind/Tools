#!/bin/env bash
# Version: autorun sql files 0.1
# MAINTAINER morrowind "@qq.com"
# set -x
# The shell that psql is to execute the given command string

# set language env
export LANG=zh_CN.UTF-8

# set variable
DATE=`date +%Y%m%d`
DB_NAME=""
BACK_PATH=""
SVN_PATH="./"
LOG_PATH="./${DATE}.log"
PSQL_BIN=`which psql`
PSQL_HOST=""
PSQL_PORT=""
PSQL_USER=""
PSQL_PASSWD=""

#getpath or filename
FIND="find ${SVN_PATH} -type f -iname *.sql"
EXEC="${PSQL_BIN} -h ${PSQL_HOST} -p ${PSQL_PORT} -U ${PSQL_USER} -L ${LOG_PATH}"


#psql -h $host -p 5432 -U $user "password=$pwd" -c 'select datname -L psq.log -o pst.log from pg_database;'
#if [ "`ls -A $SVNPATH`" = "" ]; then
if [ -d "${SVN_PATH}" ]; then
    # backup sql

    for SQLIST in `${FIND}`
    do
        DB_NAME=`grep -Ev "^--|^$" ${SQLIST} | awk -F '.' '{ print $1 }' | awk \
            '{ print $NF }' | head -n 1 | sed 's/"//g'`
        case ${DB_NAME} in
            public)
                DB_NAME="trues"
                echo ${DB_NAME}
                ;;
            *)
                DB_NAME="falsh"
                echo $DB_NAME
                ;;
        esac
        echo $DB_NAME

        ${EXEC} "password=${PSQL_PASSWD}" -f ${SQLIST}
        #while read line
        #do
            #${EXEC} < ${SQLIST} > ${LOGPATH}/${DATE}.log 2>$1
            #echo $line
        #done < ${SQLIST} | grep -Ev "^#|^$"
        #exit 1
        #echo "${SQLIST}"
    done
fi
exit 0
