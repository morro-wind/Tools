#!/bin/env python3
from pathlib import Path
from pathlib import PurePosixPath

p = Path('/home/wind')
l = list(p.glob('*.sh'))

if l:
    for i in l:
       APP = PurePosixPath(i).stem
       print(APP)

