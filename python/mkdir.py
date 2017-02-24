#!/usr/bin/env python

import os

dir_list = ['ESoopay_CBE',
            'fx_plat2-pbg',
            'fx_routePaygate',
            'CBE_Merchant_API',
            'cbJobSystem']
os.chdir('/tmp/log')
dir = os.getcwd()
print dir

for dirname in dir_list:
    if not os.path.exists(dirname):
        os.makedirs(dirname)
    print "/tmp/log/%s already exist" % dirname
