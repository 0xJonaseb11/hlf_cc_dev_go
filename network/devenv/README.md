Shell Scripts
=============
All scripts under [bin] sub folder to be executed in VM/Shell

bin/init.sh         Initializes the dev environment
bin/launch.sh       Launches the dev enviornment
bin/stop.sh         Stops the dev environment

Scripts
=======
All scripts under [scripts] folder to be executed in tools/shell

Start & Validate
================
bin
bin/launch.sh restart




peer channel fetch config airlinechannel.block -o $ORDERER_ADDRESS -c airlinechannel
peer channel join -o $ORDERER_ADDRESS -b  airlinechannel.block


Dev Setup
=========
Container#1   orderer.acme.com
    - Type solo
Container#2   acme-peer1.acme.com
Container#3   budget-peer1.budget.com
Container#4   tools

Remove all images
=================
docker rmi  $(docker images -a -q)

export CORE_VM_ENDPOINT=unix:///host/var/run/docker.sock
export  CORE_VM_DOCKER_HOSTCONFIG_NETWORKMODE=net_airline


Postgres Service
================
sudo service postgresql stop