#!/bin/bash -x

. /etc/lavavars

cat /etc/resolv.conf
# WHISKY TANGO FOXTROT
resolvconf -u
cat /etc/resolv.conf

apt-get update
apt-get -y install lsb-release git nmap vim pm-utils bridge-utils openssh-server

git clone -b arm64-trusty git://github.com/mwhudson/testing-openstack
cd testing-openstack
./setup.sh
cd /opt/stack/tempest
cp etc/logging.conf.sample etc/logging.conf
if [ "$LAVA_RUN_TEMPEST" = "yes" ]; then
    sudo -u stack ./run_tempest.sh -l -N -t -- $LAVA_TESTS_TO_RUN | tee /home/ubuntu/tempest-logs.txt
fi
if [ "$LAVA_SLEEP_FOR_ACCESS" = "yes" ]; then
    sleep 3600
fi
