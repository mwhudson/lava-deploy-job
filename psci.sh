#!/bin/bash
cat /etc/resolv.conf
# WHISKY TANGO FOXTROT
resolvconf -u
cat /etc/resolv.conf

apt-get update

mkdir scratch
cd scratch
wget http://lava-leg02/~mwhudson/linux-headers-3.15.0-5_3.15.0-5.10+mwhudson_all.deb
wget http://lava-leg02/~mwhudson/linux-headers-3.15.0-5-generic_3.15.0-5.10+mwhudson_arm64.deb
wget http://lava-leg02/~mwhudson/linux-image-3.15.0-5-generic_3.15.0-5.10+mwhudson_arm64.deb
dpkg -i *.deb
apt-get install -f
apt-get install qemu-system
wget http://lava-leg02/~mwhudson/qemu-system-aarch64
chmod a+x qemu-system-aarch64
cp qemu-system-aarch64 `which qemu-system-aarch64`
cd ../
rm -rf scratch