#!/bin/bash

# Restoring Dump
BIN=`which psql`
PG_RES=`which pg_restore`
DB_SAVE="/bak/database_backup"
DATE=`date +%Y-%m-%d`

HOST="test.com"
USER="test"
export PGPASSWORD=test

# CLOSE DATABASE CONNECT
# DROP DATABASE
drop_db(){
    while true
    do
        $BIN -h $HOST -U $USER -d postgres -lqt | cut -d \| -f 1 | grep -qw $DB
        [[ $? -ne 0 ]] && break
        $BIN -h $HOST -U $USER -d postgres -c "SELECT pg_terminate_backend(pg_stat_activity.pid) FROM pg_stat_activity WHERE datname='$DB' AND pid<>pg_backend_pid();"
        $BIN -h $HOST -U $USER -d postgres -c "DROP DATABASE $DB;"
        [[ $? -eq 0 ]] && echo "DROP $DB" && break
    done
    $BIN -h $HOST -U $USER -d postgres -c "CREATE DATABASE $DB;"
    echo "CREATE $DB"
}

restore() {
    [[ ! -f ${DB_SAVE}/$1_$2_${DATE}.sql ]] && echo "$1_$2 sql file does not exist" && exit 1
    ${PG_RES} -h ${HOST} -p 5432 -U ${USER} -c -O -d $DB ${DB_SAVE}/$1_$2_${DATE}.sql
    echo "RESTORE $DB From $1_$2"

}


case "$1" in
    pro_z)
        [[ $2 == "ps" ]] && DB=psz
        [[ $2 == "quick_os" ]] && DB=quick_osz
        drop_db
        restore $1 $2
        ;;
    pro_j)
        [[ $2 == "ps" ]] && DB=psj8
        [[ $2 == "quick_os" ]] && DB=quick_osj
        drop_db
        restore $1 $2
        ;;
esac
