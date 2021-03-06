#!/bin/env python3
# -*- coding: utf-8 -*-

from pathlib import Path
from pathlib import PurePosixPath
from subprocess import Popen, PIPE, check_output
import os
import time

DOCUMENTATION = '''
---

'''

EXAMPLES = '''

'''

def send_alarm(topic_arn, app_name, mailmessage, mailsubject):
    Popen('aws sns publish --topic-arn %s --message \
            "%s" --subject "%s"' %(topic_arn, mailmessage, mailsubject),
            shell = True, stdout = PIPE, stderr = PIPE)
    return app_name

def app_control(app_root, app_name, state):
    Popen('%s/bin/catalina.sh %s' %(app_name, state), shell = True, cwd = '%s' \
            %app_root, stdout = PIPE)

def zip_file(app_root, app_name, file_type):
    p = Popen('tar zcf %s.tgz %s.%s' %(app_name, app_name, file_type), shell = \
            True, cwd = '%s' %app_root, stderr = PIPE)
    if p.wait() == 0:
        os.remove("%s/%s.%s" %(app_root, app_name, file_type))

def main():
    argument_spec=dict(
            filepath='/opt/applog',
            apppath='/opt/app',
            appname='apache-tomcat-8.5.29',
            filename='catalina',
            state='',
            filetype='dump',
            topicarn='arn:aws:sns:ap-southeast-1:594115287305:ZAALERM',
            message=' time ',
            subject=' Production ZA application'
            )
    filepath = argument_spec['filepath']
    apppath = argument_spec['apppath']
    filename = argument_spec['filename']
    state = argument_spec['state']
    filetype = argument_spec['filetype']
    topicarn = argument_spec['topicarn']
    message = argument_spec['message']
    subject = argument_spec['subject']
    appname = argument_spec['appname']

    filepath = Path(filepath)
    list_file = list(filepath.glob('*.%s' %filetype))

    if list_file:
        for i in list_file:
            appname = PurePosixPath(i).stem
            ipaddr = Popen("ip addr show dev eth0 | grep 'global eth0' | awk \
            '{print $2}' | cut -d / -f1", shell = True, stdout = PIPE, stderr =
            PIPE)
            ipaddr = ipaddr.stdout.read().strip().decode('gb2312')
            starttime = Popen("ls -l %s | awk '{print $8}'" %i,
                    shell = True, cwd = "%s" %filepath, stdout = PIPE)
            starttime = starttime.stdout.read().strip().decode('gb2312')
            starttime = time.strftime("%Y-%m-%d", time.localtime()) + " " + starttime
            #mailmessage = subject + " alarm " + str(ipaddr) + " " + appname + " find " + filetype + message + \
            #str(starttime)
            mailmessage = '''hostip: %s
appname: %s
starttime: %s
message: application out of memrry''' %(ipaddr, appname, starttime)
            mailsubject = str(ipaddr) + " " + appname + subject + " alarm"
            send_alarm(topicarn, appname, mailmessage, mailsubject)
            time.sleep(3)
            Popen("ps axo pid,command | grep %s | grep -v grep | awk '{print \
                    $1}' | xargs kill -9" %appname, shell = True, stderr = PIPE)
            time.sleep(5)
            appstatus = Popen('ps aux | grep %s | grep -v grep' %appname, shell
                    = True, stderr = PIPE, stdout = PIPE)
            if appstatus.wait() != 0:
                state = 'start'
                app_control(apppath, appname, state)
                time.sleep(70)
                runtime = Popen("ps axo etime,command | grep %s | grep -v grep |\
                        awk '{print $1}'" %appname, shell = True, stdout = PIPE,
                        stderr = PIPE)
                if runtime.wait() == 0:
                    runtime = runtime.stdout.read().decode('GBK')
                    recoverytime = time.strftime("%m-%d %H:%M:%S", time.localtime())
                    #mailmessage = str(ipaddr) + " " + appname + recoverytime + " runing time " + str(runtime)
                    mailmessage = '''hostip: %s
appname: %s
recoverytime: %s
message: application recovery''' %(ipaddr, appname, recoverytime)
                    mailsubject = recoverytime + " Recovery start " + appname + " " + str(ipaddr)
                    send_alarm(topicarn, appname, mailmessage, mailsubject)
            zip_file(filepath, appname, filetype)

if __name__=='__main__':
    main()
