#!/bin/bash
apt-get install u-boot-tools
flash-kernel
cd /boot
mkimage -A arm -T script -C none -n "Ubuntu boot script" -d boot.script boot.scr
