#-*- coding: utf-8 -*-
#!/usr/bin/evn python
#FileName: Log_Monitor_cfg.py


from datetime import datetime
from datetime import timedelta


BakLogTime = None
LogBakPath = None

"""应用进程唯一识别名"""
AppName = 'jbossb'

"""备份日志名称时间格式"""
DateFormat = '%Y%m%d%H'

"""日志内时间格式"""
LogDateFormat = '%Y-%m-%d %H:%M:%S,%f'

"""向上获取日志的秒数"""
LogLength = 180

"""获取备份日志时间"""
TimeNow = datetime.now()
LogStartTime = TimeNow - timedelta(seconds = LogLength)
LogTime = LogStartTime.strftime(DateFormat)

if TimeNow.strftime(DateFormat) == LogTime:
    pass
else:
    BakLogTime = LogTime

"""当前日志目录"""
LogFullPath = "/usr/log/ebankpay/service_mpsp.log"

if BakLogTime:
    """上一时间段备份日志目录"""
    LogBakPath = "/usr/log/ebankpay/service_mpsp.log.%s" % (BakLogTime)
else:
    pass

"""分隔符"""
Separator = ","

"""列所在位置"""
Location = {
    "DateTime":1, 
    "RetCode":8, 
    }

"""日志列条目数策略"""
LogFunction = [
    {"Name":"RetCode", 'Value':'0000', "Method":'le', "Threshold":0},
    ]

"""日志列条目数百分比策略"""
LogFunctionPercentage = [

    ]

"""响应时间（RunTime）'大于'策略"""
LogRunTimeGE = 1

"""日志停刷不发送告警时段"""
NoLogNoALarm = [
    "20|6",
    ]
