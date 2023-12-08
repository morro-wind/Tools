#!/usr/bin/python
# -*- coding: UTF-8 -*-

import smtplib
import sys
from email.mime.text import MIMEText
from email.utils import formataddr

to_mail = sys.argv[1]
subject = sys.argv[2]
message = sys.argv[3]

from_mail = 'admin@example.com'
pwd_mail = 'password'

def mail():
    ret = True
    try:
        msg = MIMEText('%s' %message, 'plain', 'utf-8')
        msg['From'] = from_mail
        msg['To'] = to_mail
        msg['Subject'] = ('%s' %subject)

        server = smtplib.SMTP_SSL("smtpav.example.com", 465)
        server.login(from_mail, pwd_mail)
        server.sendmail(from_mail, [to_mail,], msg.as_string())
        server.quit()
    except Exception:
        ret = False
    return ret

ret=mail()
if ret:
    print("send mail successed")
else:
    print("send mail failed")

