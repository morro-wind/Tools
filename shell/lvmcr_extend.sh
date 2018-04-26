#!/bin/env bash
#Couldn't find device with uuid

vgreduce --removemissing /dev/sda or vg00
pvcreate /dev/sda
pvs
vgs
vgextend vg00 /dev/sda1 /dev/sdn1
lvextend -L +400G /dev/vg00/lv00
#Logical volume lv_data successfully resized.
lvdisplay /dev/vg00/lv00
e2fsck -f /dev/vg_app/lv_data
resize2fs /dev/vg_app/lv_data

