#!/bin/env python
# Author: lie
# Maintainer: lie
# https://redis.io/commands/info
import sys
import time
import redis
# Int / keep float
#form __future__ import division

# Create redis connect
def Connect():
    r = redis.StrictRedis(
            host=redis_host,
            port=redis_port,
            db=0
            )
    return r

# Test redis server status
def Ping():
    return Connect().ping()

def DBSize():
    print Connect().dbsize()

def Info(args):
    conn = Connect()
    args = conn.info()[args]
    return args

# Redis hit rate
def HitRate():
    conn = Connect()
    hit = conn.info()["keyspace_hits"]
    miss = conn.info()["keyspace_misses"]
    #hit = 2
    #miss = 1
    if (hit == 0 and miss == 0): # if not (hit and miss):
        print "-1" # Keyspace none
        exit(2)
    #print "hit:", hit
    #print "miss:", miss
    # Display conversion
    hitrate = 100 * hit / float(hit + miss)
    # round(a,2) keep float .02
    return round(hitrate, 2)

# CPU Utilization
def CPU():
    conn = Connect()
    cpu_before = conn.info()["used_cpu_sys"] + conn.info()["used_cpu_user"]
    time.sleep(40)
    cpu_now = conn.info()["used_cpu_sys"] + conn.info()["used_cpu_user"]
    utilization = (cpu_now - cpu_before) * 100 / 40
    print '%.2f' % utilization

if __name__ == '__main__':
    if len(sys.argv) != 4:
        print "Usage: python redis_host redis_port fields"
        exit(1)

    redis_host = sys.argv[1]
    redis_port = sys.argv[2]
    redis_fields = sys.argv[3]
    try:
        if redis_fields in "hitrate":
            print HitRate()
        elif redis_fields in "ping":
            print Ping()
        elif redis_fields in "dbsize":
            DBSize()
        elif redis_fields in "cpu_utilization":
            CPU()
        else:
            print Info(redis_fields)

    # Field argvment error
    except KeyError:
        print "-1"

    # redis connection error
    except redis.exceptions.ConnectionError:
        print "-2"

    #if Connect().ping:
    #    print "Success connect redis"

    #t = Connect()
    #print t.info()["used_memory"]
    #print HitRate()
    #print Info("used_memory")
