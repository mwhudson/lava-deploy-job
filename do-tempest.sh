#!/bin/bash
ls -l /etc

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
./run_tempest.sh -l -N -t
