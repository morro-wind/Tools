#!/bin/bash
#set -x
BIN=/DATA/opt/app/bin
BACKUP_DIR=/DATA/backup
DATE=`date +%Y%m%d`
IP=`ip addr show eth0 | grep -w inet | awk -F / '{print $1}' | awk '{print
$NF}'`
[[ ! -d ${BACKUP_DIR} ]] && mkdir ${BACKUP_DIR}
#[[ ! -x ${BIN}/pg_dumpall ]] && echo "${BIN}/pg_dumpall not except" && exit 1
[[ ! -x ${BIN}/pg_dumpall ]] && BIN="/DATA/opt/app/pgsql/bin"
[[ ! -x ${BIN}/pg_dumpall ]] && echo "$BIN/pg_dumpall is not except" && exit 1

export PGPASSWORD="postgres"
cd $BACKUP_DIR
$BIN/pg_dumpall -U postgres| gzip > ${DATE}-${IP}-pg.dump.gz
scp ${DATE}-${IP}-pg.dump.gz root@10.221.2.167:/DATA/backup/postgresql/
find ./ -type f -ctime +2 -exec rm -rf {} \;

