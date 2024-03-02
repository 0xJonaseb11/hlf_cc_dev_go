####################### https://courses.pragmaticpaths.com ##############
# Part of a course 'Mastering Fabric Chaincode Development using GoLang'#
# http://www.bcmentors.com      raj@acloudfan.com                       #
#########################################################################

Utility Scripts for Development
===============================
set-env.sh              Sets the peer env variables
set-chain-env.sh        Sets the peer env variables in a file
show-env.sh             Shows the current env setup

Cleanup Script
==============
Execute this to release system resources 
santize.sh              Removes the temporary volumes & unsets env vars

Scripts for dev environment management
======================================
dev-init.sh             Initializes and launches the dev setup
dev-stop.sh             Shutsdown the environment
dev-launch.sh           Launches the environment

Test with node & java
=====================
set-chain-env.sh   -l node -p $GOPATH/src/chaincode_example02/node -n nodecc -v 1 -C airlinechannel \
                   -c '{"Args":["init","a","100","b","300"]}' -q '{"Args":["query","b"]}' -i  '{"Args":["invoke","a","b","5"]}'

set-chain-env.sh   -l java -p $GOPATH/src/chaincode_example02/java -n javacc -v 1 -C airlinechannel \
                   -c '{"Args":["init","a","100","b","300"]}' -q '{"Args":["query","b"]}' -i  '{"Args":["invoke","a","b","5"]}'


Expt:
created the nodechaincode folder unde the bin folder - worked
executed this in bin folder
set-chain-env.sh -p $PWD/nodechaincode/chaincode_example02 -n nodecc3

This didnt work
set-chain-env.sh -p $PWD/../nodechaincode/chaincode_example02 -n nodecc5

Changed to / project folfr
set-chain-env.sh -p $PWD/nodechaincode/chaincode_example02 -n nodecc4

set-chain-env.sh -p $PWD/../javachaincode/chaincode_example02 -n javacc2 -l java

Test - non gopath go
====================
set-chain-env.sh -p $PWD/../gochaincode/chaincode_example02 -n gocc1 -l golang

export GOPATH=/vagrant/gochaincode
set-chain-env.sh -p chaincode_example02 -n gocc1 -l golang

Explorer
========
exp-regen.sh        Regenerates the database

Unit Testin
===========
Include the $BINS_FOLDER/utest.sh in your unit test scripts
Arguments must be quoted e.g., assert_json_equal "$QUERY_RESULT" 
All peer command failures will abort the execution of the test script
Not suggested to be used in DEV mode as the state may changed - 
Events not captured

Couch DB
========
Environment needs to be initialized with the option -s 
The 5984 port is forwarded so you may access the fauxton interface
http://localhost:5984/_utils

Launching the explorer
======================
Explorer may be launched as part of the dev-init using the -e flag
    - dev-init.sh -e
    - dev-start.sh      Starts 
    - dev-stop.sh       Stops
OR it may be launched/shutdown using the 
    - exp-start.sh
    - exp-stop.sh