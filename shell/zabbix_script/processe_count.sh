#!/bin/bash
# Count processes and thread

PID=``
ps m -p $PID | wc -l
ps aux | wc -l
 grep Threads /proc/$PID/status | awk '{print $NF}'
