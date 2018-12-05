#!/bin/bash
export PGPASSWORD=
HOST=
USER=
BIN=`which psql`
PG_BIN=`which pg_dump`
DB_SAVE=
DATE=`date +%Y%m%d`
DB1=
DB2=

# Dump
$PG_BIN -h $HOST -U $USER -d $DB1 | gzip > ${DB_SAVE}/$DB1-${DATE}.gz
$PG_BIN -h $HOST -U $USER -d $DB2 | gzip > ${DB_SAVE}/$DB2-${DATE}.gz

# Stop App

# Restoring Dump
HOST=
USER=
export PGPASSWORD=
# DROP DATABASE
$BIN -h $HOST -U $USER -d postgres -c "DROP DATABASE $DB1;"
$BIN -h $HOST -U $USER -d postgres -c "DROP DATABASE $DB2;"

# CREATE DATABASE
$BIN -h $HOST -U $USER -d postgres -c "CREATE DATABASE $DB1;"
$BIN -h $HOST -U $USER -d postgres -c "CREATE DATABASE $DB2;"

#$BIN -h $HOST -U $USER -d $DB2 < ${DB_SAVE}/$DB2-${DATE}.sql
#$BIN -h $HOST -U $USER -d $DB1 < ${DB_SAVE}/$DB1-${DATE}.sql
gunzip -c ${DB_SAVE}/$DB2-${DATE}.gz | $BIN -h $HOST -U $USER -d $DB2
gunzip -c ${DB_SAVE}/$DB1-${DATE}.gz | $BIN -h $HOST -U $USER -d $DB1

# Start App
