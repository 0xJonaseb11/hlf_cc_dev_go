#!/bin/bash
# Updated : Fabric 2.x : April 2020

if [ -z $SUDO_USER ]
then
    echo "===== Script need to be executed with sudo ===="
    echo "Change directory to 'setup'"
    echo "Usage: sudo ./caserver.sh"
    exit 0
fi

source ./to_absolute_path.sh

echo "=======Set up go (Takes a loooong time - get a coffee :)======"

# Get the version 1.13 from google
wget https://dl.google.com/go/go1.13.3.linux-amd64.tar.gz
act='ttyout="*"'
tar -xf go1.13.3.linux-amd64.tar.gz --checkpoint --checkpoint-action=$act -C /usr/local 
rm go1.13.3.linux-amd64.tar.gz

# If GOROOT already set then DO Not set it again
if [ -z $GOROOT ]
then
    echo "export GOROOT=/usr/local/go" >> ~/.profile
    echo "export PATH=$PATH:/usr/local/go/bin" >> ~/.profile

    GOPATH=$PWD/../../gocc
    to-absolute-path $GOPATH
    GOPATH=$ABS_PATH

    echo "export GOPATH=$GOPATH" >> ~/.profile
    echo "======== Updated .profile with GOROOT/GOPATH/PATH===="

    echo "export GOROOT=/usr/local/go" >> ~/.bashrc
    echo "export GOPATH=$GOPATH" >> ~/.bashrc
    echo "======== Updated .profile with GOROOT/GOPATH/PATH===="

    # UPDATED Dec 15, 2019
    echo "export GOCACHE=~/.go-cache" >> ~/.bashrc
    mkdir -p $GOCACHE
    chown -R $USER $GOCACHE


else
    echo "======== No Change made to .profile ====="
fi

echo "======= Done. PLEASE LOG OUT & LOG Back In ===="
echo "Then validate by executing    'go version'"