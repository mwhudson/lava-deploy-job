#!/bin/bash

# This is needed because we are lying to LAVA about how booting works...
resolvconf -u

. /etc/lavavars

if [ "$LAVA_PSCI" != "yes" ]; then
    exit 0
fi

apt-get update

mkdir scratch
cd scratch
wget http://lava-leg02/~mwhudson/linux-headers-3.15.0-5_3.15.0-5.10+hyperscale.1_all.deb
wget http://lava-leg02/~mwhudson/linux-headers-3.15.0-5-generic_3.15.0-5.10+hyperscale.1_arm64.deb
wget http://lava-leg02/~mwhudson/linux-image-3.15.0-5-generic_3.15.0-5.10+hyperscale.1_arm64.deb
dpkg -i *.deb
apt-get install -f
apt-get install -y qemu-system
wget http://lava-leg02/~mwhudson/qemu-system-aarch64
chmod a+x qemu-system-aarch64
cp qemu-system-aarch64 `which qemu-system-aarch64`
cd ../
rm -rf scratch
cd /boot
cat boot.scr
cat boot.script
mkimage -A arm -T script -C none -n "Ubuntu boot script" -d boot.script boot.scr
cat boot.scr
rm /etc/udev/rules.d/70-persistent-net.rules || true
sync
sync
sleep 60
sync
