#!/bin/bash

docker-compose down

# REMOVE the dev- container images also - TBD
docker rm $(docker ps -a -q)            &> /dev/null
docker rmi $(docker images dev-* -q)    &> /dev/null
sudo rm -rf $HOME/ledgers/ca &> /dev/null

docker-compose up -d

SLEEP_TIME=3s
echo    '========= Submitting txn for channel creation as AcmeAdmin ============'
export CHANNEL_TX_FILE=./config/airline-channel.tx
export ORDERER_ADDRESS=orderer.acme.com:7050
# export FABRIC_LOGGING_SPEC=DEBUG
export CORE_PEER_LOCALMSPID=AcmeMSP
export CORE_PEER_MSPCONFIGPATH=$PWD/client/acme/admin/msp
export CORE_PEER_ADDRESS=acme-peer1.acme.com:7051
peer channel create -o $ORDERER_ADDRESS -c airlinechannel -f ./config/airlinechannel.tx

echo    '========= Joining the acme-peer1 to Airline channel ============'
AIRLINE_CHANNEL_BLOCK=./airlinechannel.block
export CORE_PEER_ADDRESS=acme-peer1.acme.com:7051
peer channel join -o $ORDERER_ADDRESS -b $AIRLINE_CHANNEL_BLOCK
# Update anchor peer on channel for acme
# sleep  3s
sleep $SLEEP_TIME
ANCHOR_UPDATE_TX=./config/airline-anchor-update-acme.tx
peer channel update -o $ORDERER_ADDRESS -c airlinechannel -f $ANCHOR_UPDATE_TX

echo    '========= Joining the budget-peer1 to Airline channel ============'
# peer channel fetch config $AIRLINE_CHANNEL_BLOCK -o $ORDERER_ADDRESS -c airlinechannel
export CORE_PEER_LOCALMSPID=BudgetMSP
ORG_NAME=budget.com
export CORE_PEER_ADDRESS=budget-peer1.budget.com:8051
export CORE_PEER_MSPCONFIGPATH=$PWD/client/budget/admin/msp
peer channel join -o $ORDERER_ADDRESS -b $AIRLINE_CHANNEL_BLOCK
# Update anchor peer on channel for budget
sleep  $SLEEP_TIME
ANCHOR_UPDATE_TX=./config/airline-anchor-update-budget.tx
peer channel update -o $ORDERER_ADDRESS -c airlinechannel -f $ANCHOR_UPDATE_TX

