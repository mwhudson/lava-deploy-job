#!/bin/bash -x

mkdir ~/.juju
cp ./scripts/environments.yaml ~/.juju
juju bootstrap
#juju add-machine ssh:controller01
juju add-machine ssh:compute01

juju-deployer -e manual -c ./scripts/minimal.yaml
