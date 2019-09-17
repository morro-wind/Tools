#!/bin/env python3
# -*- coding: utf-8 -*-

from pathlib import Path
from pathlib import PurePosixPath
from subprocess import Popen, PIPE
import os

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
topic_arn = "arn:aws:sns:ap-southeast-1:594115287305:ALERMNopro"
topic_arn = "test "
topic_arn = topic_arn + "send topic"
print("%s" %topic_arn)
'''

class DumpFileAlarm(object):
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

    def send_alarm(self, app_name, mailmessage, mailsubject):
        app_name = app_name
        self.message = app_name + " " + mailmessage
        self.subject = app_name + " " + mailsubject
        Popen('aws sns publish --topic-arn %s --message \
                "%s" --subject "%s"' %(topic_arn, self.message, self.subject), shell = True)
        return app_name

    def app_control(self, app_root, app_name, state):
        Popen('%s/bin/catalina.sh %s' %(app_name, state), shell =
                True, cwd = '%s' %app_root)

    def zip_file(self, app_root, app_name, file_type):
        p = Popen('tar zcf %s.tgz %s.%s' %(app_name, app_name, file_type), shell =
                True, cwd = '%s' %app_root, stderr = PIPE)
        if p.wait() == 0:
            os.remove("%s/%s.%s" %(app_root, app_name, file_type))
            print("success")
        else:
            print("failed")
def main():
    argument_spec=dict(
            filepath='/home/wind',#'/home/wind/Downloads/apache-tomcat-8.5.29/logs',
            apppath='/home/wind/Downloads',
            appname='apache-tomcat-8.5.29',
            filename='catalina',
            state='',
            filetype='sh',
            topicarn='arn:aws:sns:ap-southeast-1:594115287305:ALERMNopro'
            )
    filepath = argument_spec['filepath']
    apppath = argument_spec['apppath']
    filename = argument_spec['filename']
    state = argument_spec['state']
    filetype = argument_spec['filetype']
    topicarn = argument_spec['topicarn']
    print(topicarn)

    filepath = Path(filepath)
    list_file = list(filepath.glob('*.%s' %filetype))
    print(list_file)


    #dumpfilealarm = DumpFileAlarm(argument_spec)
    if list_file:
        for i in list_file:
            appname = PurePosixPath(i).stem
            print(appname)
            continue
            s = self.send_alarm(appname, mailmessage, mailsubject)
            print(s + " " + app_name)
            self.restart_application(appname)
            self.send_alarm(appname)
            self.zip_file(appname)


if __name__=='__main__':
    main()
#    DumpFileAlarm().find_file()

#    DumpFileAlarm().app_control("/home/wind/Downloads",
#            "apache-tomcat-8.5.29", "start")
#    DumpFileAlarm().zip_file("/home/wind/Downloads/apache-tomcat-8.5.29/logs",
#            "catalina", "out")
