#!/bin/bash -x

. /etc/lavavars

# This is needed because we are lying to LAVA about how booting works...
resolvconf -u

echo never > /sys/kernel/mm/transparent_hugepage/enabled

apt-get update
apt-get -y install lsb-release git nmap vim pm-utils bridge-utils openssh-server subunit

git clone -b arm64-trusty git://github.com/mwhudson/testing-openstack
cd testing-openstack
./setup.sh
cd /opt/stack/tempest
mkdir /home/ubuntu/attachments
if [ "$LAVA_RUN_TEMPEST" = "yes" ]; then
    sudo -u stack testr init
    sudo -u stack testr list-tests $LAVA_TESTS_TO_RUN | tail -n +6 > /home/ubuntu/attachments/all-tests.txt
    sudo -u stack testr run --subunit --load-list=/home/ubuntu/attachments/all-tests.txt | tail -n +6 | tee results.subunit | subunit-2to1 | tools/colorizer.py
    cat results.subunit | subunit2csv --no-passthrough > /home/ubuntu/attachments/results.csv
    cd /opt/stack/log
    tar -czf /home/ubuntu/attachments/devstack-logs.tgz .
fi
if [ "$LAVA_SLEEP_FOR_ACCESS" = "yes" ]; then
    sleep 3600
fi
sync
sleep 60
sync
