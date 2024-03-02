echo "NOT Needed"

exit

export PATH=$PATH:$GOROOT/bin

# Sets up the fabric-ca-server & fabric-ca-client
sudo apt install -y libtool libltdl-dev

# Document process leads to errors as it leads to pulling of master branch
go get -u github.com/hyperledger/fabric-ca/cmd/...


sudo cp $GOPATH/bin/*    /usr/local/bin

sudo cp $GOPATH/bin/*    $PWD/../bin

sudo rm $GOPATH/bin/* 

echo "Done. Log out & Log back in ...."


