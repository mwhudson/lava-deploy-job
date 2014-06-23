#!/bin/bash -x

mkdir ~/.juju
cp ./scripts/environments.yaml ~/.juju
cp ./scripts/minimal.yaml ~
juju bootstrap
#juju add-machine ssh:controller01
juju add-machine ssh:compute01

cd
juju-deployer -e manual -c minimal.yaml
