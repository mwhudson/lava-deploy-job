#!/bin/bash -x

. /etc/lavavars

# This is needed because we are lying to LAVA about how booting works...
resolvconf -u

echo never > /sys/kernel/mm/transparent_hugepage/enabled

apt-get update
apt-get -y install lsb-release git nmap vim pm-utils bridge-utils openssh-server

git clone -b arm64-trusty git://github.com/mwhudson/testing-openstack
cd testing-openstack
./setup.sh
cd /opt/stack/tempest
cp etc/logging.conf.sample etc/logging.conf
mkdir /home/ubuntu/attachments
if [ "$LAVA_RUN_TEMPEST" = "yes" ]; then
    testr list-tests $LAVA_TESTS_TO_RUN > /home/ubuntu/attachments/all-tests.txt
    sudo -u stack ./run_tempest.sh -l -N -t -- $LAVA_TESTS_TO_RUN 2>&1 | tee /home/ubuntu/attachments/tempest-logs.txt
    apt-get install subunit
    testr last --subunit | subunit-1to2 | subunit2csv > /home/ubuntu/attachments/results.csv
    cd /opt/stack/log
    tar -czf /home/ubuntu/attachments/devstack-logs.tgz .
fi
if [ "$LAVA_SLEEP_FOR_ACCESS" = "yes" ]; then
    sleep 3600
fi
sync
sleep 60
sync
