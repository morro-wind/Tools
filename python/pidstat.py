#!/usr/bin/python

import commands
import sys
#import pdb;pdb.set_trace()

appport = sys.argv[1]
pidargs = sys.argv[2]

(status, PID) = commands.getstatusoutput("sudo netstat -lntp | grep -w %s |\
        awk '{print $NF}' | awk -F / '{print $1}' | sed -n '$p'" % appport)

def change_ke(cmd):
    (status,result_tmp) = commands.getstatusoutput(cmd)
    result_tmp = result_tmp.split("\n")
    result_key = result_tmp[0].split()
    result_values = result_tmp[1].split()
    result = dict(zip(result_key, result_values))
    return result

# Report I/O statistics.
# kB_rd/s:Number of kilobytes the task has caused to be read from disk per
# second.
# kB_wr/s:Number of kilobytes the task has caused, or shall cause to be written
# to disk per second.
# kB_ccwr/s:Number of kilobytes whose writing to disk has been cancelled by the
# task. This may occur when the task truncates some dirty pagecache. In this case,
# some IO which another task has been accounted for will not be happening.
if pidargs in ('rd', 'wr', 'ccwr'):
    #cmd_util = "pidstat -ld -p " + PID + " | sed -n '3,$p'"
    cmd_util = "pidstat -ld -p " + PID + " | sed -n '3,$p' | sed 's/kB_\|\/s//g'"
    util = change_ke(cmd_util)
    print util.get(pidargs)

# Report page faults and memory utilization
elif pidargs in ('minflt', 'majflt', 'VSZ', 'RSS', 'MEM'):
    cmd_util = "pidstat -lr -p " + PID + " | sed -n '3,$p' | sed 's/\/s\|%//g'"
    util = change_ke(cmd_util)
    print util.get(pidargs)

# Report CPU utilization
elif pidargs in ('usr', 'cpu', 'system', 'guest', 'CPU'):
    cmd_util = "pidstat -lu -p " + PID + " | sed -n '3,$p' | \
            sed 's/%CPU/cpu/g' | sed 's/\%//g'"
    util = change_ke(cmd_util)
    print util.get(pidargs)

# Report Threads and
elif pidargs in ('Threads', 'State', 'VmPeak', 'VmStk', 'FDSize'):
    cmd_util = "grep -iw %s /proc/%s/status | awk '{print $2}'" % (pidargs, PID)
    (status,result_tmp) = commands.getstatusoutput(cmd_util)
    print(result_tmp)

# Report stack utilization
'''
elif pidargs in ('StkSize', 'StkRef'):
    cmd_util = "pidstat -ls -p %s | sed -n '3,$p'" % PID
    util = change_ke(cmd_util)
    print util.get(pidargs)

# Report values of some kernel tables
elif pidargs in ('threads', 'fd-nr'):
    cmd_util = "pidstat -lv -p %s | sed -n '3,$p'" % PID
    util = change_ke(cmd_util)
    print util.get(pidargs)
'''
