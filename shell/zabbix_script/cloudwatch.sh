#/bin/bash
cd `dirname $0`
HOSTNAME=`hostname`

TOTAL_DISK_SPACE=$(/bin/bash vfs_fs_size.sh / total)
USED_DISK_SPACE=$(/bin/bash vfs_fs_size.sh / used)
FREE_DISK_SPACE=$(/bin/bash vfs_fs_size.sh / free)
PUSE_DISK_SPACE=$(/bin/bash vfs_fs_size.sh / puse)

PUSE_INODES=$(/bin/bash vfs_fs_size.sh / puse)

TOTAL_MEMORY=$(/bin/bash system_memory.sh total)
USED_MEMORY=$(/bin/bash system_memory.sh used)
FREE_MEMORY=$(/bin/bash system_memory.sh free)
BUFFER_MEMORY=$(/bin/bash system_memory.sh buffers)
CACHE_MEMORY=$(/bin/bash system_memory.sh cached)
APP_FREE=$((${FREE_MEMORY} + ${BUFFER_MEMORY} + ${CACHE_MEMORY}))
PFREE_MEMORY=$(awk 'BEGIN{ print "'$FREE_MEMORY'" / "'$TOTAL_MEMORY'" * 100 }')

NET_ESTAB=$(/bin/bash system_network_connections.sh established $APPORT)
NET_TMWT=$(/bin/bash system_network_connections.sh time_wait $APPORT)
NET_CSWT=$(/bin/bash system_network_connections.sh close_wait $APPORT)

PID_MAX=$(cat /proc/sys/kernel/pid_max)
FILE_MAX=$(cat /proc/sys/fs/file-max)

aws cloudwatch put-metric-data --namespace DiskSpace --metric-name "TotalDiskSapceOn /" \
    --unit Kilobytes --value ${TOTAL_DISK_SPACE} --dimensions InstanceId=${HOSTNAME}
aws cloudwatch put-metric-data --namespace DiskSpace --metric-name "UsedDiskSapceOn /" \
    --unit Kilobytes --value ${USED_DISK_SPACE} --dimensions InstanceId=${HOSTNAME}
aws cloudwatch put-metric-data --namespace DiskSpace --metric-name "FreeDiskSapceOn /" \
    --unit Kilobytes --value ${FREE_DISK_SPACE} --dimensions InstanceId=${HOSTNAME}
aws cloudwatch put-metric-data --namespace DiskSpace --metric-name "PUseDiskSapceOn /" \
    --unit Percent --value ${PUSE_DISK_SPACE} --dimensions InstanceId=${HOSTNAME}

aws cloudwatch put-metric-data --namespace Inodes --metric-name "UseInodes /" \
    --unit Percent --value ${PUSE_INODES} --dimensions InstanceId=${HOSTNAME}

aws cloudwatch put-metric-data --namespace Memory --metric-name "TotalMemory" \
    --unit Kilobytes --value ${TOTAL_MEMORY} --dimensions InstanceId=${HOSTNAME}
aws cloudwatch put-metric-data --namespace Memory --metric-name "UsedMemory" \
    --unit Kilobytes --value ${USED_MEMORY} --dimensions InstanceId=${HOSTNAME}
aws cloudwatch put-metric-data --namespace Memory --metric-name "SysFreeMemory" \
    --unit Kilobytes --value ${FREE_MEMORY} --dimensions InstanceId=${HOSTNAME}
aws cloudwatch put-metric-data --namespace Memory --metric-name "AppFreeMemory" \
    --unit Kilobytes --value ${APP_FREE} --dimensions InstanceId=${HOSTNAME}
aws cloudwatch put-metric-data --namespace Memory --metric-name "PFreeMemory" \
    --unit Percent --value ${PFREE_MEMORY} --dimensions InstanceId=${HOSTNAME}

aws cloudwatch put-metric-data --namespace "OS" --metric-name "Established" \
    --unit Count --value ${NET_ESTAB} --dimensions InstanceId=${HOSTNAME}
aws cloudwatch put-metric-data --namespace "OS" --metric-name "TimeWait" \
    --unit Count --value ${NET_TMWT} --dimensions InstanceId=${HOSTNAME}
aws cloudwatch put-metric-data --namespace "OS" --metric-name "CloseWait" \
    --unit Count --value ${NET_CSWT} --dimensions InstanceId=${HOSTNAME}
aws cloudwatch put-metric-data --namespace "OS" --metric-name "OpenFileMax" \
    --unit Count --value ${FILE_MAX} --dimensions InstanceId=${HOSTNAME}
aws cloudwatch put-metric-data --namespace "OS" --metric-name "ProcesseMax" \
    --unit Count --value ${PID_MAX} --dimensions InstanceId=${HOSTNAME}
