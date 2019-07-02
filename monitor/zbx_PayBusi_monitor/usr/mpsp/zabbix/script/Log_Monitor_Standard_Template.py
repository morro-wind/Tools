#-*- coding: utf-8 -*-
#!/usr/bin/evn python
#FileName: Log_Monitor_Standard_Template.py



import sys
import re
import Log_Monitor_cfg
from datetime import datetime
import types
from time import time
import commands


def GetLog():

    if not Log_Monitor_cfg.LogBakPath:
        try:
            LogFile = open(Log_Monitor_cfg.LogFullPath, 'rb')
            try:
                LogFileInfo = LogFile.readlines()[::-1]
                Count_ = 1
                for line in LogFileInfo:
                    Time_ = re.split(Log_Monitor_cfg.Separator, line)[(Log_Monitor_cfg.Location["DateTime"] -1)]
                    if Time_ <= Log_Monitor_cfg.LogStartTime.strftime(Log_Monitor_cfg.LogDateFormat):
                        Count_ += LogFileInfo.index(line)
                        break
                if Count_ != 1:
                    LogFileInfo = LogFileInfo[:Count_]
                else:
                    LogFileInfo = []
                LogFile.close()
            except Exception, e:
                return 'GetLog Error Code:[%s]' % (e)
        finally:
            if LogFile:
                LogFile.close()
                LogFile = None
            Count_ = None
            Time_ = None
        
        return LogFileInfo

    else:
        try:
            LogFile = None
            LogFileOld = None
            LogFile = open(Log_Monitor_cfg.LogFullPath, 'rb')
            try:
                LogFileInfo = LogFile.readlines()[::-1]
                line = LogFileInfo[-1]
                Time_ = re.split(Log_Monitor_cfg.Separator, line)[(Log_Monitor_cfg.Location["DateTime"] -1)]
                if Time_ <= Log_Monitor_cfg.LogStartTime.strftime(Log_Monitor_cfg.LogDateFormat):
                    LogFileInfo = []
                    return LogFileInfo
                try:
                    LogFileOld = open(Log_Monitor_cfg.LogBakPath, 'rb')
                    try:
                        LogFileInfoOld = LogFileOld.readlines()[::-1]
                        Count_ = 1
                        for line in LogFileInfoOld:
                            Time_ = re.split(Log_Monitor_cfg.Separator, line)[(Log_Monitor_cfg.Location["DateTime"] -1)]
                            if Time_ <= Log_Monitor_cfg.LogStartTime.strftime(Log_Monitor_cfg.LogDateFormat):
                                Count_ += LogFileInfoOld.index(line)
                                break
                        if Count_ != 1:
                            LogFileInfo += LogFileInfoOld[:Count_]
                        return LogFileInfo
                    except Exception, e:
                        return 'GetLog2 Error Code:[%s]' % (e)
                except Exception, e:
                    return 'Open File Error Code:[%s]' % (e)
            except Exception, e:
                return 'GetLog1 Error Code:[%s]' % (e)
        finally:
            if LogFile:
                LogFile.close() 
            if LogFileOld:
                LogFileOld.close()
            Count_ = None
            Time_ = None



def GetLogResult(LogInfo):

    Count_ = len(LogInfo)
    Counts = {}
    RunTimeCount = 0
    RunTimeMax = 0
    RetInfo = ''
    LogFunc = Log_Monitor_cfg.LogFunction
    LogFuncP = Log_Monitor_cfg.LogFunctionPercentage
    for rule in LogFunc:
        Counts[rule.get("Name")] = Counts.get(rule.get("Name"), {})
        Counts[rule.get("Name")][rule.get("Value")] = Counts[rule.get("Name")].get(rule.get("Value"), 0)
    for rule in LogFuncP:
        Counts[rule.get("Name")] = Counts.get(rule.get("Name"), {})
        Counts[rule.get("Name")][rule.get("Value")] = Counts[rule.get("Name")].get(rule.get("Value"), 0)
    for line in LogInfo:
        TimeInfo = re.split(Log_Monitor_cfg.Separator, line)[(Log_Monitor_cfg.Location["RunTime"] - 1)]
        '''print re.split(Log_Monitor_cfg.Separator, line)'''
        if int(TimeInfo) >= int(Log_Monitor_cfg.LogRunTimeGE):
            RunTimeCount += 1
            if int(TimeInfo) >= RunTimeMax:
                RunTimeMax = int(TimeInfo)
        for key in Counts:
            Column = re.split(Log_Monitor_cfg.Separator, line)[(Log_Monitor_cfg.Location[key] - 1)]
            for Value in Counts[key]:
                if Value == Column:
                    Counts[key][Value] += 1
    if RunTimeCount != 0:
        RetInfo += """APP Runing Time >= %sms happend %sTimes Max: %sms !""" % (Log_Monitor_cfg.LogRunTimeGE, RunTimeCount, RunTimeMax)
    if LogFunc:
        for Rule in LogFunc:
            if Rule["Method"] == 'ge':
                if Counts[Rule['Name']][Rule['Value']] >= Rule["Threshold"]:
                    RetInfo += """ColumName:%s Code: %s >= %s Now: %s !""" % (Rule['Name'], Rule['Value'], Rule["Threshold"], Counts[Rule['Name']][Rule['Value']])
            elif Rule["Method"] == 'le':
                if Counts[Rule['Name']][Rule['Value']] <= Rule["Threshold"]:
                    RetInfo += """ColumName:%s Code: %s <= %s Now: %s !""" % (Rule['Name'], Rule['Value'], Rule["Threshold"], Counts[Rule['Name']][Rule['Value']])
    if LogFuncP:
        for Rule in LogFuncP:
                if Rule["Method"] == 'ge':
                    if Counts[Rule['Name']][Rule['Value']] / float(Count_) * 100 >= Rule["Threshold"]:
                        RetInfo += """ColumName:%s Code: %s >= %s%% Now: %s%% !""" % (Rule['Name'], Rule['Value'], Rule["Threshold"], Counts[Rule['Name']][Rule['Value']] / float(Count_) * 100)
                elif Rule["Method"] == 'le':
                    if Counts[Rule['Name']][Rule['Value']] / float(Count_) * 100 <= Rule["Threshold"]:
                        RetInfo += """ColumName:%s Code: %s <= %s%% Now: %s%% !""" % (Rule['Name'], Rule['Value'], Rule["Threshold"], Counts[Rule['Name']][Rule['Value']] / float(Count_) * 100)
    return RetInfo

def CheckAPP():
    cmd = "pgrep -f %s -l | grep java | grep -v grep | awk '{print $1}'" % (Log_Monitor_cfg.AppName)
    PID = commands.getoutput(cmd)
    if PID:
        GetStatus = commands.getoutput("ps -ax | grep %s | awk '{print $3}'" % (PID))
        if GetStatus == 'Z':
            return '%s Now is a Zombie Process!' % (Log_Monitor_cfg.AppName)
        PortStatus = commands.getoutput("netstat -lnpt | grep %s" % (PID))
        if PortStatus:
            return 'ok'
    else:
        return 'No Process Named %s!' % (Log_Monitor_cfg.AppName)

if __name__ == "__main__":
    Info = GetLog()
    if Info:
        """has log or str"""
        if type(Info) == types.StringType:
            """has str"""
            print Info
        else:
            """has log"""
            result = GetLogResult(Info)
            if result:
                print result
            else:
                print 'ok'
    else:
        """No log"""
        for line in Log_Monitor_cfg.NoLogNoALarm:
            if Log_Monitor_cfg.TimeNow.strftime('%H') >= line.split('|')[0] and Log_Monitor_cfg.TimeNow.strftime('%H') <= line.split('|')[1]:
                Flag = True
            else:
                Flag = False
        if Flag == True:
            if CheckAPP() == 'ok':
                print 'ok'
            else:
                print CheckApp()
        else:
            print 'APP Log Stoped !'
