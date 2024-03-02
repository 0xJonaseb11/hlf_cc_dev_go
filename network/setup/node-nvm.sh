#!/bin/bash
# Installs node JS and the utilities
# Updated : Fabric 2.x : April 2020
# https://www.digitalocean.com/community/tutorials/how-to-install-node-js-on-ubuntu-18-04

mkdir temp &> /dev/null
cd temp

# Get NVM
curl -sL https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh -o install_nvm.sh

# Install NVM
bash install_nvm.sh

# Include the function
source ~/.nvm/nvm.sh

# Install the LTS
nvm install 12.16.2

# Switch to the LTS
nvm use 12.16.2

echo "nvm use 12.16.2" >> ~/.profile
echo "nvm use 12.16.2" >> ~/.bashrc

# sudo apt-get install g++ -y

# source ~/.profile
# source ~/.bashrc