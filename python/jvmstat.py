#!/usr/bin/python
import commands
import sys

#sys.path.append("/home/ec2-user/jdk1.7.0_80/bin")

app_port=sys.argv[1]
jvmargs=sys.argv[2]

(status, PID) = commands.getstatusoutput("sudo netstat -lntp | grep -w %s | awk \
        '{print $NF}' | awk -F '/' '{print $1}' | sed -n '$p'" % app_port)
#print(commands.getstatusoutput("echo $PATH"))
#print(PID)
def change_ke(cmd):
    (status, result_tmp) = commands.getstatusoutput(cmd)
    #print(commands.getstatusoutput(cmd))
    result_tmp = result_tmp.split('\n')
    result_key = result_tmp[0].split()
    result_values = result_tmp[1].split()
    result = dict(zip(result_key, result_values))
    return result

if jvmargs in ('S0C', 'S1C', 'S0U', 'S1U', 'EC', 'EU', 'OC', 'OU', 'PC', 'PU'):
    cmd_util = "sudo -u ec2-user jstat -gc %s" % PID
    util = change_ke(cmd_util)
    print util.get(jvmargs)

elif jvmargs in ('S0', 'S1', 'E', 'O', 'P', 'YGC', 'YGCT', 'FGC', 'FGCT', 'GCT'):
    cmd_util = "sudo -u ec2-user jstat -gcutil %s" % PID
    util = change_ke(cmd_util)
    print util.get(jvmargs)

elif jvmargs in ('Loaded', 'Unloaded'):
    cmd_util = "sudo -u ec2-user jstat -class %s" % PID
    util = change_ke(cmd_util)
    print util.get(jvmargs)

elif jvmargs in ('NGCMN', 'NGCMX', 'NGC', 'OGCMN', 'OGCMX', 'OGC', 'PGCMN', 'PGCMX', 'PGC'):
    cmd_util = "sudo -u ec2-user jstat -gccapacity %s" % PID
    util = change_ke(cmd_util)
    print util.get(jvmargs)

elif jvmargs in ('TT', 'MTT', 'DSS'):
    cmd_util = "sudo -u ec2-user jstat -gcnew %s" % PID
    util = change_ke(cmd_util)
    print util.get(jvmargs)

elif jvmargs in ('S0CMX', 'S1CMX', 'ECMX'):
    cmd_util = "sudo -u ec2-user jstat -gcnewcapacity %s" % PID
    util = change_ke(cmd_util)
    print util.get(jvmargs)

'''
elif jvmargs in ('LGCC', 'GCC'):
    cmd_util = "sudo -u ec2-user jstat -gccause %s" % PID
    util = change_ke(cmd_util)
    print util.get(jvmargs)
'''

