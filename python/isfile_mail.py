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

'''
log_root = Path('/home/wind')
print("log root %s" %log_root)
app_root = "/home/wind"
print("app root %s" %app_root)
list_file = list(log_root.glob('*.sh'))
app_name = None
topic_arn = ""
topic_arn = "test "
topic_arn = topic_arn + "send topic"
print("%s" %topic_arn)
'''

#class DumpFileAlarm(object):
'''
    def find_file(self):
        if list_file:
            for i in list_file:
                app_name = PurePosixPath(i).stem
                s = self.send_alarm(app_name, mailmessage, mailsubject)
                print(s + " " + app_name)
                self.restart_application(app_name)
                self.send_alarm(app_name)
                self.zip_file(app_name)
    '''

def send_alarm(topic_arn, app_name, mailmessage, mailsubject):
    #message = app_name + " " + mailmessage
    #subject = app_name + " " + mailsubject
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
            filepath='/home/wind/Downloads/apache-tomcat-8.5.29/logs',
            apppath='/home/wind/Downloads',
            appname='apache-tomcat-8.5.29',
            filename='catalina',
            state='',
            filetype='log',
            topicarn='',
            message=' time ',
            subject='Production A application'
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
            #starttime = check_output("ls -l %s | awk '{print $8}'" %i,
            #        shell = True, cwd = "%s" %filepath)
            starttime = Popen("ls -l %s | awk '{print $8}'" %i,
                    shell = True, cwd = "%s" %filepath, stdout = PIPE)
            starttime = starttime.stdout.readline().strip()
            #starttime = starttime.splitlines()
            #starttime = eval("%s" %starttime)
            mailmessage = appname + " create " + filetype + message + \
            str(starttime)
            mailsubject = appname + subject + " alarm"
            #send_alarm(topicarn, appname, mailmessage, mailsubject)
            print("send dump")
            #time.sleep(10)
            appname='apache-tomcat-8.5.29'
            Popen("ps axo pid,command | grep %s | grep -v grep | awk '{print \
                    $1}' | xargs kill -9" %appname, shell = True, stderr = PIPE)
            #time.sleep(3)
            appstatus = Popen('ps aux | grep %s | grep -v grep' %appname, shell
                    = True, stderr = PIPE, stdout = PIPE)
            if appstatus.wait() != 0:
                state = 'start'
                app_control(apppath, appname, state)
                runtime = Popen("ps axo etime,command | grep %s | grep -v grep |\
                        awk '{print $1}'" %appname, shell = True)
                print("")
                if runtime.wait() == 0:
                    mailmessage = appname + "runing time " + str(runtime)
                    mailsubject = "Recovery start " + appname
                    #send_alarm(topicarn, appname, mailmessage, mailsubject)
                    print("send start")
            zip_file(filepath, appname, filetype)

if __name__=='__main__':
    main()
#    DumpFileAlarm().find_file()

#    DumpFileAlarm().app_control("/home/wind/Downloads",
#            "apache-tomcat-8.5.29", "start")
#    DumpFileAlarm().zip_file("/home/wind/Downloads/apache-tomcat-8.5.29/logs",
#            "catalina", "out")
