#!/bin/bash

mkdir ~/.juju
cp /opt/lava-scripts/environments.yaml ~/.juju
juju bootstrap
juju add-machine ssh:controller01
juju add-machine ssh:compute01

sleep 3600

