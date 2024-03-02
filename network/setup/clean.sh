# Deletes the folders from the project
# BUT does not Uninstall/remove binaries
# Execute this script in setup folder

SETUP_FOLDER=$PWD

# Shutdown containers
echo "=== Shutting down containers ==="
dev-stop.sh &> /dev/null

rm -rf ../fabric-samples 2> /dev/null
echo "===> fabric-samples deleted ==="

rm -rf $GOPATH/bin 2> /dev/null
rm -rf $GOPATH/pkg 2> /dev/null
rm -rf $GOPATH/src/github.com 2> /dev/null
echo "===> GOPATH folder deleted ==="

#Clean the config objects
rm $SETUP_FOLDER/../config/*.tx 2> /dev/null
rm $SETUP_FOLDER/../config/*.block 2> /dev/null

#Clean the cryptogen folders
rm -rf $SETUP_FOLDER/../crypto/crypto-config
echo "===> delete crypto material"

#Clean the app folder
cd $SETUP_FOLDER/../../app
./clean.sh
cd $SETUP_FOLDER

rm $SETUP_FOLDER/../../history

# remove the GOPATH/github & token & bin
rm -rf $SETUP_FOLDER/../../gocc/src/github.com

cd  $SETUP_FOLDER/../../gocc/src/token
./clean.sh

# Remove bin & pkg folders
rm -rf $SETUP_FOLDER/../../gocc/bin
rm -rf $SETUP_FOLDER/../../gocc/pkg

cd $SETUP_FOLDER

# Clean the sample code
rm -rf $GOPATH/src/token
rm -rf $GOPATH/src/testing
rm -rf $GOPATH/src/acflogger
rm -rf $GOPATH/src/snippets



# Clean up the folder .vagrant
echo "==================CLEAN UP Task Done. ================="
echo "To Remove VM. Please run the command   'vagrant destroy' on host machine"