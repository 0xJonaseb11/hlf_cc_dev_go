#!/bin/bash
# Installs node JS and the utilities
# Updated : Fabric 2.x : April 2020

echo "====== Installing the npm build tools ======"
sudo apt update
sudo apt-get install g++ -y

echo "====== Installing node | npm ======"
sudo ./node-nvm.sh

sudo chown -R $USER:$(id -gn $USER) /home/vagrant/.config
sudo chown -R $USER $HOME/.npm

source ~/.profile
source ~/.bashrc
source ~/.nvm/nvm.sh

echo "====== Installing utilities - Almost there :) ======"
rm -rf temp &> /dev/null
mkdir temp
cd temp

# If owner is not changed we get a Warning (Harmless but annoying)
mkdir -p  $HOME/.config
# sudo chown -R $(whoami) $HOME/.config
sudo chown -R $USER $HOME/.config
sudo chown -R $USER $HOME/.npm
git clone  https://github.com/acloudfan/HLFChaincode_Utils.git

# Remove the previous version if any
sudo rm -rf $HOME/HLFChaincode_Utils &> /dev/null
sleep 2s
# Move the latest version 
mv HLFChaincode_Utils  $HOME

# Change directory and do an npm install
cd $HOME/HLFChaincode_Utils
npm install

cd ..
rm -rf temp 

echo "====== Please Logout & Logback in ======"