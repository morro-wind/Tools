#!/bin/env bash
# Version: autorun sql files 0.2
# MAINTAINER morrowind "@qq.com"
# Set -x
# The shell that psql is to execute the given command string

# Set language env
export LANG=zh_CN.UTF-8
# Modify path contains space issue
SAVE_IFS=$IFS
IFS='
'

# Set variable
DATE=$1
[[ -z ${DATE} ]] && DATE=`date +%Y%m%d`
DB_NAME=""
BACK_PATH=""
SVN_PATH="./"
SVN_BIN=""
SVN_USER=""
SVN_PWD=""
SVN_ADDR=""
LOG_PATH="./"
PSQL_BIN=`which psql`
PSQL_HOST=""
PSQL_PORT=""
PSQL_USER=""
PSQL_PASSWD=""

if [ ! -d ${SVN_PATH} ]; then
    svn co --username ${SVN_USER} --password "${SVN_PWD}" \
       ${SVN_ADDR} ${SVN_PATH} >> ${LOG_PATH}/svn.log
else
    svn up ${SVN_PATH} >> ${SVN_LOG}
fi

# Getpath or filename
cd ${SVN_PATH}
#FIND="find ${SVN_PATH}/${DATE} -type f -iname *.sql"
EXEC="${PSQL_BIN} -h ${PSQL_HOST} -p ${PSQL_PORT} -U ${PSQL_USER} \
    password=${PSQL_PASSWD} -L ${LOG_PATH}"
# Auto input pwd
#http://blog.163.com/yang_jianli/blog/static/16199000620172134742161?ignoreua
# View library
# https://www.cnblogs.com/wzzkaifa/p/6852301.html
#psql -h $host -p 5432 -U $user "password=$pwd" -c "SELECT datname from pg_database;"
# View database size
# https://my.oschina.net/u/347414/blog/544187
#"SELECT pg_size_pretty(pg_database_size('dataname'));"
#if [ "`ls -A $SVNPATH`" = "" ]; then

if [ -d "${SVN_PATH}/${DATA}" ]; then
    # backup sql
    # http://blog.csdn.net/badly9/article/details/50386259
    #pg_dump ${DB_NAME} | gzip > ${BACK_PATH}/${DB_NAME}_${DATE}.gz

    for SQLIST in `find ${SVN_PATH}/${DATE} -type f -iname "*.sql"`
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

        ${EXEC} "password=${PSQL_PASSWD}" -d ${DB_NAME} -f ${SQLIST}

        # Copy
        #cat ${SQLIST} >> ${VSQL_PATH}/${VER}_${DB_NAME}.sql
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
