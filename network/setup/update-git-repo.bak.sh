#!/bin/sh
#Updates the repos for sample code
#You may execute this script anytime to update the sample code

cd $GOPATH/src

# Get the latest samples 
echo "Getting the sample code..."
rm -rf token &> /dev/null
rm -rf HLFGO-Token &> /dev/null
rm -rf ./testing &> /dev/null
rm -rf ./HLFGO-Testing &> /dev/null

sleep 2s

git clone   https://github.com/acloudfan/HLFGO-Token.git  token


echo "Getting the testing code..."

git clone  https://github.com/acloudfan/HLFGO-Testing.git  testing


echo "Done. Updated the sample code under $GOPATH/src"
