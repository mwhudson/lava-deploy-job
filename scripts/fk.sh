#!/bin/bash -x
apt-get install u-boot-tools
flash-kernel
cd /boot
mkimage -A arm -T script -C none -n "Ubuntu boot script" -d boot.script boot.scr
sed -i -e 's/ttyAMA0/ttyS0/g' /etc/init/ttyAMA0.conf > /etc/init/ttyS0.conf
