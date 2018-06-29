#!/bin/env python
import sys
import psycopg2
import psycopg2.extras

args = sys.argv[1]
dbname = sys.argv[2]

conn = psycopg2.connect(
        database='mydb',
        user='python',
        password='python',
        host='127.0.0.1',
        port=5432
        )

cursor = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
#cursor.execute('SELECT version();')
#cursor.execute('select current_database();')
#cursor.execute("select datid,datname,numbackends from pg_stat_database where datname='mydb';")
#item = cursor.fetchone()
#print item
if args in ('version'):
    cursor.execute("select %s();" % args)
    #item = cursor.fetchone()
    #print item

# Output database dbid, DBNAME,
elif args in ('datid', 'datname', 'numbackends'):
    #cursor.execute("SELECT %s FROM pg_stat_database WHERE datname=%s;" % datid,quick_ods)
    cursor.execute(
            "SELECT %s FROM pg_stat_database WHERE datname='%s';"
            % (args, dbname)
            )

item = cursor.fetchone()
print item
conn.close()
