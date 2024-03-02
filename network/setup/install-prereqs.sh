#!/bin/bash
# Updated : Fabric 2.x : April 2020

# DO NOT Execute this script with sudo
if [ $SUDO_USER ]; then
    echo "Please DO NOT execute with sudo !!!    ./install-prereqs.sh"
    echo "Aborting!!!"
    exit 0
fi
sudo ./docker.sh    
sudo ./compose.sh   
sudo -E ./go.sh     

# Install JQ
sudo apt-get install -y jq



echo "====== Please Logout & Logback in ======"