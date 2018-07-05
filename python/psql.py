#!/bin/env python
import sys
import psycopg2
import psycopg2.extras

args = sys.argv[1]
dbname = sys.argv[2]
dbip = sys.argv[3]

'''
def connect(db_name, user_name, pass_wd, host_ip, host_port):
    conn = psycopg2.connect(
        database = db_name,
        user = user_name,
        password = pass_wd,
        host = host_ip,
        port = host_port
        )
    return conn;
'''

conn = psycopg2.connect(
        database=dbname,
        user='python',
        password='python',
        host=dbip,
        port=5432
        )

#conn = connect(dbname, 'python', 'python', '127.0.0.1', '5432')
cursor = conn.cursor(cursor_factory=psycopg2.extras.DictCursor)
#cursor.execute('SELECT version();')
#cursor.execute('select current_database();')
#cursor.execute("select datid,datname,numbackends from pg_stat_database where datname='mydb';")
#item = cursor.fetchone()
#print item
if args in ('version'):
    cursor.execute("select %s();" % args)
    item = cursor.fetchone()
    print item[0]

# Output database dbid, DBNAME,
elif args in ('datid', 'datname', 'numbackends'):
    #cursor.execute("SELECT %s FROM pg_stat_database WHERE datname=%s;" % datid,quick_ods)
    cursor.execute(
            "SELECT %s FROM pg_stat_database WHERE datname='%s';"
            % (args, dbname)
            )
    item = cursor.fetchone()
    print item[0]
elif args in ('uptime'):
    cursor.execute(
            "SELECT pg_postmaster_start_time();"
            )
    item = cursor.fetchone()
    print item[0]
elif args in 'cntime':
    cursor.execute("SELECT pg_conf_load_time();")
    item = cursor.fetchone()
    print item[0]
elif args in 'query':
    #cursor.execute("SELECT current_query();")
    cursor.execute("SELECT query FROM pg_stat_activity;")
    item = cursor.fetchall()
    print item
elif args in 'size':
    # https://www.postgresql.org/docs/9.4/static/functions-admin.html
    # select database size
    cursor.execute(
            "SELECT pg_database_size('%s');"
            % (dbname)
            )

    # select database size KB,MB,GB
    '''
    cursor.execute(
            "SELECT pg_size_pretty(pg_database_size('%s'));"
            % (dbname)
            )
    '''
    item = cursor.fetchone()
    print item[0]
elif args in 'locks':
    '''
    cursor.execute(
            "SELECT pg_class.relname AS table, pg_database.datname AS \
            database, pid, mode, granted FROM pg_locks, pg_class, pg_database \
            WHERE pg_locks.relation = pg_class.oid AND pg_locks.database = \
            pg_database.oid;"
            )
    '''
    cursor.execute(
            "SELECT pg_class.relname FROM pg_locks, pg_class, pg_database \
            WHERE pg_locks.relation = pg_class.oid AND pg_locks.database = \
            pg_database.oid;"
            )
    item = cursor.fetchall()
    print item
conn.close()
