#!/bin/bash
# updated for Ubuntu 18.04
# Updated : Fabric 2.x : April 2020

# https://www.digitalocean.com/community/tutorials/how-to-install-node-js-on-ubuntu-18-04

sudo apt update
sudo apt install nodejs -y

sudo apt install npm -y
nodejs -v

# # install build tools
# sudo apt install build-essential -y
# Install 
apt-get install g++ -y

# Using version 12.x of node
cd ~
curl -sL https://deb.nodesource.com/setup_12.x -o nodesource_setup.sh

sudo bash nodesource_setup.sh
sudo apt install nodejs -y

