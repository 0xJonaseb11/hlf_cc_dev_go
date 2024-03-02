#!/bin/bash
# Updated : Fabric 2.x : April 2020

if [ -z $SUDO_USER ]; then
    echo "Script MUST be executed with 'sudo -E'"
    echo "Abroting!!!"
    exit 0
fi

if [ -z $GOPATH ]; then
    echo "GOPATH not set!!! You must use 'sudo -E ./install-fabric.sh'"
    echo "Aborting!!!"
    exit 0
fi

SETUP_FOLDER=$PWD

source ./to_absolute_path.sh

export PATH=$PATH:$GOROOT/bin

echo "GOPATH=$GOPATH"
echo "GOROOT=$GOROOT"

mkdir -p $GOPATH

# Execute in the setup folder
echo "=== Must execute in the setup folder ===="

rm -rf ./temp 2> /dev/null
# create temp directory
mkdir temp  &> /dev/null
cd temp

echo "====== Starting to Download Fabric ========"
curl -sSL http://bit.ly/2ysbOFE -o bootstrap.sh
chmod 755 ./bootstrap.sh
bash ./bootstrap.sh -- 2.0.1 1.4.6 0.4.18


echo "======= Copying the binaries to /usr/local/bin===="
cp ./fabric-samples/bin/*    /usr/local/bin


# This downloads the shim package 
echo "======= Setting up the HLF Shim (Takes time - get a coffee :)===="
go get github.com/hyperledger/fabric-chaincode-go/shim
go get github.com/hyperledger/fabric-chaincode-go/shimtest

# Clean up
cd ..
rm -rf  temp

# The sample chaincode is under the subfolder go and need to come under gopath/src subfolder
cd $SETUP_FOLDER

BIN_PATH=$PWD/../bin
to-absolute-path $BIN_PATH
BIN_PATH=$ABS_PATH

echo "export PATH=$PATH:$BIN_PATH:$GOPATH/bin" >> ~/.profile
echo "export PATH=$PATH:$BIN_PATH:$GOPATH/bin" >> ~/.bashrc

chmod u+x $BIN_PATH/*.sh


# Update /etc/hosts
cd $SETUP_FOLDER

source    ./manage_hosts.sh
HOSTNAME=acme-peer1.acme.com
removehost $HOSTNAME            &> /dev/null
addhost $HOSTNAME
HOSTNAME=budget-peer1.budget.com
removehost $HOSTNAME            &> /dev/null
addhost $HOSTNAME
HOSTNAME=orderer.acme.com
removehost $HOSTNAME            &> /dev/null
addhost $HOSTNAME
HOSTNAME=postgresql
removehost $HOSTNAME            &> /dev/null
addhost $HOSTNAME
HOSTNAME=explorer
removehost $HOSTNAME            &> /dev/null
addhost $HOSTNAME

echo "Done. Logout and Log back in !!"
