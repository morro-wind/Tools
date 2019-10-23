#!/bin/env python3
"""File content format processing
search keywork output
"""

import re
a = ''
with open(r'log.log') as file:
    lines = file.readlines()

for line in lines:
    a = a + line.strip()

print(a)
newfile = re.sub(r'\[#', "\n[#", a)

pattern = re.compile(r'\[#.*LCC:(.*?)\..*TimeCost=(.*?);.*Action=(.*?);.*')

stdoutfile = pattern.findall(newfile)
print(stdoutfile)

'''
with open(r'log.log') as file:
    line = file.readline()
    while line:
        a = a + line.strip()
print(a)
'''
