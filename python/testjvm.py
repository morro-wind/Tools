import commands
import sys

jvmargs=sys.argv[1]

(status, PID) = commands.getstatusoutput("jps | grep Bootstrap$ | grep -v Jps | \
        awk '{print $1}'")
print(PID)
def change_gc_ke(cmd):
    (status,gcresult_tmp) = commands.getstatusoutput(cmd)
    gcresult_tmp = gcresult_tmp.split('\n')
    gcresult_key = gcresult_tmp[0].split()
    gcresult_values = gcresult_tmp[1].split()
    gcresult = dict(zip(gcresult_key, gcresult_values))
    print (gcresult)
    return gcresult

if jvmargs in ('S0', 'S1'):
    cmd_gcutil = "jstat -gcutil " + PID
    gcutil = change_gc_ke(cmd_gcutil)
    print gcutil.get(jvmargs)
(Test1) = commands.getstatusoutput("jps | grep Bootstrap$ | grep -v \
        Jps | awk '{print $1}'")
print(Test1)
