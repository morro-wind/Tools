#!/bin/env python3
from pathlib import Path
from pathlib import PurePosixPath
from subprocess import Popen

file_root = Path('/home/wind')
list_file = list(file_root.glob('*.sh'))
app_name = None
topic_arn = arn:aws:sns:ap-southeast-1:594115287305:ALERMNopro

class DumpFileAlarm:

    def find_file(self):
        if list_file:
            for i in list_file:
                app_name = PurePosixPath(i).stem
                s = self.send_alarm(app_name)
                print(s + " " + app_name)
                self.restart_application(app_name)
                self.send_alarm(app_name)
                self.zip_file(app_name)

    def send_alarm(self, app_name, **started):
        Popen('aws sns publish --topic-arn %s --message
                "%s" --subject "test appname"' %(topic_arn,p),  shell=True)
        p = app_name
        return p

    def restart_application(self, app_name):
        pass

    def zip_file(self, app_name):
        pass

if __name__=='__main__':
    DumpFileAlarm().find_file()
