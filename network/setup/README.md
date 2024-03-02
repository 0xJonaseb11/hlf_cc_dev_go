# Updated for Fabric 2.0
# April 2020
# v2.0 Link


# 1 Open a terminal
cd network/setup

# 2 Install Pre-Requisites & Validate
./install-prereqs.sh
Log out & Log back in - type exit and enter
./validate-prereqs.sh

# 3 Install the Fabric binaries & images
sudo -E ./install-fabric.sh
Log out & Log back in
./validate-fabric.sh

# 4 Install Hyperledger Explorer tool
./install-explorer.sh
Log out & Log back in
./validate-explorer.sh

# 5 Install the Go Tools
./install-gotools.sh

# 6 Install Node JS - used by the utilities 
# To use some of the utilities Node JS is needed
./install-node-utils.sh


#

# Update the sample code
cd network/setup
./update-git-repo.sh


# Managing etc/hosts
Update the etc/hosts
sudo ./manage_hosts.sh
cat /etc/hosts              << Shows the IP mapping for various components >>


