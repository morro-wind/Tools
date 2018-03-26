#!/bin/env bash
# Version: copy sql format files 0.1
# MAINTAINER yinglie "1713931181@qq.com"
# Set -x
# The shell that copy file format DATE_Version_DBNAME.sql
# Environment dependence file format is UTF-8

# Set language env
export LANG=zh_CN.UTF-8
IFS='
'
[[ $# != 2 ]] && exit 1
# Set variable
DATE=$1
DATE1=${DATE:2:7}
VERSION=$2
#[ -z "${DATE}" ] && DATE=`date +%Y%m%d`
DB_NAME=""
BACK_PATH=""
SVN_PATH="./sql"
SVN_BIN=`which svn`
SVN_USER=""
SVN_PWD=""
SVN_ADDR=""
SVN_LOG="./svn-${DATE}.log"
LOG_PATH="./${DATE}.log"
#PSQL_BIN=`which psql`
#PSQL_HOST="127.0.0.1"
#PSQL_PORT="5432"
#PSQL_USER="postgres"
#PSQL_PASSWD="passwd"
VERSION_PATH="./${VERSION}_${DATE1}"
SCHEMA_NAME=""

#if [ ! -d ${SVN_PATH} ]; then
#    svn co --username ${SVN_USER} --password "${SVN_PWD}" \
#        ${SVN_ADDR} ${SVN_PATH} >> ${SVN_LOG}
#else
#    svn up ${SVN_PATH} >> ${SVN_LOG}
#fi

# Getpath or filename
cd ${SVN_PATH}
#FIND="find ${SVN_PATH}/${DATE} -type f -name "*.sql[txt]""
#PSQ_EXEC="${PSQL_BIN} -h ${PSQL_HOST} -p ${PSQL_PORT} -U ${PSQL_USER} \
#    password=${PSQL_PASSWD} -L ${LOG_PATH}"

[[ ! -d "${SVN_PATH}/${DATE}" ]] && echo "${DATE} days documents do not\
    exist."

for SQLIST in `find ${SVN_PATH}/${DATE} -type f -name "*.sql" -o -name "*.txt"`
do
    START=`grep -n "/\*" ${SQLIST} | head -n 1 | awk -F ":" '{ print $1 }'`

    if [ -z ${START} ]; then
        #Filtration Windows format Enter  = ctrl + v ctrl+m
        #Filtration grep "" | dos2unix filename | sed 's///g' filename
        SCHEMA_NAME=`grep -Ev "^--|^$|^" ${SQLIST} | awk -F '.' '{ print $1 }'\
            | awk '{ print $NF }' | head -n 1 | sed 's/"//g'`
    else
        END=`grep -n "\*/" ${SQLIST} | head -n 1 | awk -F ":" '{ print $1 }'`
        SCHEMA_NAME=`sed "${START},${END}"d ${SQLIST} | grep -Ev "^--|^$|/\*|^"\
            | awk -F '.' '{ print $1 }' | awk '{ print $NF }' | head -n 1\
            | sed 's/"//g'`
    fi
    case ${SCHEMA_NAME} in
        true)
        DB_NAME="A"
        ;;
        falsh|*)
        DB_NAME="B"
        ;;
    esac
    [[ ! -d ${VERSION_PATH} ]] && mkdir -p ${VERSION_PATH}
    #echo "${SCHEMA_NAME} in ${DB_NAME}" >> dbname.txt
    echo "${SQLIST} ---- ${SCHEMA_NAME} ---- ${DB_NAME}" > ./list.txt
    cat ${SQLIST} >> ${VERSION_PATH}/${VERSION}_${DB_NAME}.sql

    #${PSQ_EXEC} -d ${DB_NAME} -f ${SQLIST}
done
exit 0
