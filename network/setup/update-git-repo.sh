#!/bin/sh
#Updates the repos for sample code
#You may execute this script anytime to update the sample code

# read -p  "Would you like to  proceed? (y/n) " USER_RESPONSE
# if [ "$USER_RESPONSE" != "y" ]; then
#     exit
# fi

if [ -d "$GOPATH/src/chaincode_example02" ] ||
   [ -d "$GOPATH/src/snippets" ] ||
   [ -d "$GOPATH/src/acflogger" ] ||
   [ -d "$GOPATH/src/token" ] ||
   [ -d "$GOPATH/src/testing" ]; then 

    echo "To Update the Sample code !!!"
    echo "Please delete ALL of the following folders & execute:"
    echo "> cd network/sample    > ./update-git-repo.sh"
    echo "$GOPATH/src/chaincode_example02"
    echo "$GOPATH/src/token"
    echo "$GOPATH/src/testing"
    echo "$GOPATH/src/acflogger"
    echo "$GOPATH/src/snippets"
    exit
fi

rm -rf $HOME/temp &> /dev/null
# mkdir $HOME/temp

git clone https://github.com/acloudfan/HLF-GO-2.0.git  $HOME/temp

cp -r $HOME/temp/* $GOPATH/src
rm -rf $HOME/temp



# rm -rf $GOPATH/src/token   &> /dev/null
# rm -rf $GOPATH/src/testing &> /dev/null
# rm -rf $GOPATH/src/chaincode_example02 &> /dev/null
# rm -rf $GOPATH/src/snippets &> /dev/null


# mv $HOME/temp/testing $GOPATH/src
# mv $HOME/temp/token $GOPATH/src
# mv $HOME/temp/chaincode_example02 $GOPATH/src
# mv $HOME/temp/snippets $GOPATH/src

# rm -rf $HOME/temp &> /dev/null
# rmdir $HOME/temp &> /dev/null

# exit

# cd $GOPATH/src

# # Get the latest samples 
# echo "Getting the sample code..."
# rm -rf token &> /dev/null
# rm -rf HLFGO-Token &> /dev/null
# rm -rf ./testing &> /dev/null
# rm -rf ./HLFGO-Testing &> /dev/null

# sleep 2s

# git clone   https://github.com/acloudfan/HLFGO-Token.git  token


# echo "Getting the testing code..."

# git clone  https://github.com/acloudfan/HLFGO-Testing.git  testing


# echo "Done. Updated the sample code under $GOPATH/src"
