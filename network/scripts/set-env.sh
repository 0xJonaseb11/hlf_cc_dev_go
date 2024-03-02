#!/bin/bash

usage() {
    echo ". set-env.sh   ORG_NAME   [PEER_NAME default=acme-peer1]  [IDENTITY default=admin] [PORT_NUMBER_BASE default=7050] [ORDERER_ADDRESS default=orderer.acme.com:7050] "
    echo "               Sets the environment variables for the peer that need to be administered"
    echo "               If [Identity] is specified then the MSP is set to the specified Identity instead of admin"
}

# Change this to appropriate level
# export CORE_LOGGING_LEVEL=debug  #debug  #info #warning
export FABRIC_LOGGING_SPEC='debug'

# Sets the ORG Name
if [ -z $1 ];
then
    usage                            
    echo "Please provide the ORG Name!!!"
    return
else
    ORG_NAME=$1
    echo "Switching the Org = $ORG_NAME"
fi
# Sets the Peer Name for Address
if [ -z $2 ];
then
    echo "Switching PEER_NAME for Org = acme-peer1"
    PEER_NAME=acme-peer1
else
    PEER_NAME=$2
fi

# Sets the identity
if [ -z $3 ]
then
    # do nothing
    echo "Identity=admin"
    IDENTITY=admin
else
    IDENTITY=$3
    
fi

# Sets the port numbe for the peer
PORT_NUMBER_BASE=7050
if [ -z $4 ]
then
    echo "Setting PORT_NUMBER_BASE=7050"   
else
    PORT_NUMBER_BASE=$4
fi

# ORDERER_ADDRESS
if [ -z $5 ]
then
    echo "Setting ORDERER_ADDRESS=orderer.acme.com:7050"   
    export ORDERER_ADDRESS=orderer.acme.com:7050
else
    ORDERER_ADDRESS=$5
fi


export CORE_PEER_ID=$PEER_NAME


# Create the path to the crypto config folder
CRYPTO_CONFIG_ROOT_FOLDER=/var/hyperledger/crypto
export CORE_PEER_MSPCONFIGPATH=$CRYPTO_CONFIG_ROOT_FOLDER/$ORG_NAME.com/users/Admin@$ORG_NAME.com/msp

# Capitalize the first letter of Org name e.g., acme => Acme  budget => Budget
MSP_ID="$(tr '[:lower:]' '[:upper:]' <<< ${ORG_NAME:0:1})${ORG_NAME:1}"
export CORE_PEER_LOCALMSPID=$MSP_ID"MSP"

# Create the Peer host name
PEER_ADDRESS="$PEER_NAME.$ORG_NAME.com"

# Setup the peer addresses
VAR=$((PORT_NUMBER_BASE+1))
#export CORE_PEER_LISTENADDRESS=$PEER_ADDRESS:$VAR
export CORE_PEER_ADDRESS=$PEER_ADDRESS:$VAR
#VAR=$((PORT_NUMBER_BASE+2))
#export CORE_PEER_CHAINCODELISTENADDRESS=$PEER_ADDRESS:$VAR
VAR=$((PORT_NUMBER_BASE+3))
export CORE_PEER_EVENTS_ADDRESS=$PEER_ADDRESS:$VAR


#export CORE_VM_ENDPOINT=unix:///host/var/run/docker.sock

# Simply checks if this script was executed directly on the terminal/shell
# it has the '.'
if [[ $0 = *"set-env.sh" ]]
then
    echo "Did you use the . before ./set-env.sh? If yes then we are good :)"
fi