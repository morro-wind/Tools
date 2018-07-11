#!/bin/base/env python
import sys
import redis

'''
REDIS_HOST = ''
REDIS_PORT =
REDIS_DB =
REDIS_PASSWORD =
'''

redis_config = {
        "host": "localhost",
        "port": 6379
        }
redis_conn = redis.Redis(**redis_config)
print redis_conn.info()["used_memory"]
print str(redis_conn.ping())

'''
def connect(self):
    r = redis.StrictRedis(
            host='localhost',
            port=6379,
            db=0
            )
    #info = r.info()
    #print str(info[self])
    #return str(info[self])
    return r
#print connect("used_memory")
connect("used_memory")
'''
'''
def connect(self):
    r = redis.StrictRedis(
            host='localhost',
            port=6379,
            db=0
            )
    return r
def tinfo(self):
    conn = connect.info()
    print str(conn[self])
tinfo("used_memory")
'''
