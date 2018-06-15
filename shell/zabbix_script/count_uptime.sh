# Output system up time, default second
date -d "$(awk -F. '{print $1}' /proc/uptime) second ago" +"%Y-%m-%d %H:%M:%S"
2018-06-11 09:26:26
# Count system run time
cat /proc/uptime|
awk -F. '{run_days=$1 / 86400;run_hour=($1 % 86400)/3600;run_minute=($1 %
3600)/60;run_second=$1 %
60;printf("系统已运行：%d天%d时%d分%d秒",run_days,run_hour,run_minute,run_second)}'

