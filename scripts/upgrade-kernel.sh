#!/bin/bash

# This is needed because we are lying to LAVA about how booting works...
resolvconf -u

. /etc/lavavars

if [ -z "$LAVA_CUSTOM_KERNEL_VERSION" ]; then
    exit 0
fi

apt-get update

mkdir scratch
cd scratch
wget http://lava-leg02/~mwhudson/linux-headers-${LAVA_CUSTOM_KERNEL_VERSION}_all.deb
wget http://lava-leg02/~mwhudson/linux-headers-${LAVA_CUSTOM_KERNEL_VERSION}_arm64.deb
wget http://lava-leg02/~mwhudson/linux-image-${LAVA_CUSTOM_KERNEL_VERSION}_arm64.deb
dpkg -i *.deb
apt-get install -f
apt-get install -y qemu-system
wget http://lava-leg02/~mwhudson/qemu-system-aarch64
chmod a+x qemu-system-aarch64
cp qemu-system-aarch64 `which qemu-system-aarch64`
cd ../
rm -rf scratch
cd /boot
mkimage -A arm -T script -C none -n "Ubuntu boot script" -d boot.script boot.scr
rm /etc/udev/rules.d/70-persistent-net.rules || true
sync
sync
sleep 60
sync
