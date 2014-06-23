#!/bin/bash -x

resolvconf -u

export PATH=$PATH:/lava/bin
ln -s /lava /lava-$(lava-self)

mkdir -p ~ubuntu/.ssh
cp /opt/lava-scripts/id_rsa* ~ubuntu/.ssh
cat ~ubuntu/.ssh/id_rsa.pub >> ~ubuntu/.ssh/authorized_keys
chown -R ubuntu:ubuntu ~ubuntu/.ssh
chmod 0600 ~ubuntu/.ssh/id_rsa
chmod 0644 ~ubuntu/.ssh/id_rsa.pub
chmod 0700 ~ubuntu/.ssh
cat >> ~ubuntu/.ssh/config <<EOF
StrictHostKeyChecking no
EOF
ssh ubuntu@compute01 true
ssh ubuntu@controller01 true

if [ `lava-role` = "controller" ]; then
    apt-get install -y juju-core
    sudo -u ubuntu PATH=$PATH /opt/lava-scripts/do-packaged-stack-controller.sh
fi

sleep 3600
