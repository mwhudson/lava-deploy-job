#!/bin/bash -x

resolvconf -u

/opt/lava-scripts/set-up-hosts-file.sh

mkdir -p ~ubuntu/.ssh
cp /opt/lava-scripts/id_rsa* ~ubuntu/.ssh
cat ~ubuntu/.ssh/id_rsa.pub >> ~ubuntu/.ssh/authorized_keys
chown ubuntu:ubuntu ~ubuntu/.ssh
chmod 0600 ~ubuntu/.ssh/id_rsa
chmod 0644 ~ubuntu/.ssh/id_rsa.pub
chmod 0700 ~ubuntu/.ssh

ssh ubuntu@compute01 true
ssh ubuntu@controller01 true
