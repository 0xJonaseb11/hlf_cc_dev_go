docker-compose -f docker-compose-ca.yaml down
rm -rf ./server/*
rm -rf ./client/*
cp fabric-ca-server-config.yaml ./server
docker-compose -f docker-compose-ca.yaml up -d

sleep 3s

# Bootstrap enrollment
export FABRIC_CA_CLIENT_HOME=$PWD/client/caserver/admin
fabric-ca-client enroll -u http://admin:adminpw@localhost:7054


######################
# Admin registration #
######################
echo "Registering: acme-admin"
ATTRIBUTES='"hf.Registrar.Roles=peer,user,client","hf.AffiliationMgr=true","hf.Revoker=true","hf.Registrar.Attributes=*"'
fabric-ca-client register --id.type client --id.name acme-admin --id.secret adminpw --id.affiliation acme --id.attrs $ATTRIBUTES

# 3. Register budget-admin
echo "Registering: budget-admin"
ATTRIBUTES='"hf.Registrar.Roles=peer,user,client","hf.AffiliationMgr=true","hf.Revoker=true","hf.Registrar.Attributes=*"'
fabric-ca-client register --id.type client --id.name budget-admin --id.secret adminpw --id.affiliation budget --id.attrs $ATTRIBUTES

# 4. Register orderer-admin
echo "Registering: orderer-admin"
ATTRIBUTES='"hf.Registrar.Roles=orderer"'
fabric-ca-client register --id.type client --id.name orderer-admin --id.secret adminpw --id.affiliation orderer --id.attrs $ATTRIBUTES


####################
# Admin Enrollment #
####################
export FABRIC_CA_CLIENT_HOME=$PWD/client/acme/admin
fabric-ca-client enroll -u http://acme-admin:adminpw@localhost:7054
mkdir -p $FABRIC_CA_CLIENT_HOME/msp/admincerts
cp $FABRIC_CA_CLIENT_HOME/../../caserver/admin/msp/signcerts/*  $FABRIC_CA_CLIENT_HOME/msp/admincerts

export FABRIC_CA_CLIENT_HOME=$PWD/client/budget/admin
fabric-ca-client enroll -u http://budget-admin:adminpw@localhost:7054
mkdir -p $FABRIC_CA_CLIENT_HOME/msp/admincerts
cp $FABRIC_CA_CLIENT_HOME/../../caserver/admin/msp/signcerts/*  $FABRIC_CA_CLIENT_HOME/msp/admincerts

export FABRIC_CA_CLIENT_HOME=$PWD/client/orderer/admin
fabric-ca-client enroll -u http://orderer-admin:adminpw@localhost:7054
mkdir -p $FABRIC_CA_CLIENT_HOME/msp/admincerts
cp $FABRIC_CA_CLIENT_HOME/../../caserver/admin/msp/signcerts/*  $FABRIC_CA_CLIENT_HOME/msp/admincerts

#################
# Org MSP Setup #
#################
# Path to the CA certificate
ROOT_CA_CERTIFICATE=./server/ca-cert.pem
mkdir -p ./client/orderer/msp/admincerts
mkdir ./client/orderer/msp/cacerts
mkdir ./client/orderer/msp/keystore
cp $ROOT_CA_CERTIFICATE ./client/orderer/msp/cacerts
cp ./client/orderer/admin/msp/signcerts/* ./client/orderer/msp/admincerts   

mkdir -p ./client/acme/msp/admincerts
mkdir ./client/acme/msp/cacerts
mkdir ./client/acme/msp/keystore
cp $ROOT_CA_CERTIFICATE ./client/acme/msp/cacerts
cp ./client/acme/admin/msp/signcerts/* ./client/acme/msp/admincerts   

mkdir -p ./client/budget/msp/admincerts
mkdir ./client/budget/msp/cacerts
mkdir ./client/budget/msp/keystore
cp $ROOT_CA_CERTIFICATE ./client/budget/msp/cacerts
cp ./client/budget/admin/msp/signcerts/* ./client/budget/msp/admincerts   

######################
# Orderer Enrollment #
######################
export FABRIC_CA_CLIENT_HOME=$PWD/client/orderer/admin
fabric-ca-client register --id.type orderer --id.name orderer --id.secret adminpw --id.affiliation orderer 
export FABRIC_CA_CLIENT_HOME=$PWD/client/orderer/orderer
fabric-ca-client enroll -u http://orderer:adminpw@localhost:7054
cp -a $PWD/client/orderer/admin/msp/signcerts  $FABRIC_CA_CLIENT_HOME/msp/admincerts

####################
# Peer Enrollments #
####################
export FABRIC_CA_CLIENT_HOME=$PWD/client/acme/admin
fabric-ca-client register --id.type peer --id.name acme-peer1 --id.secret adminpw --id.affiliation acme 
export FABRIC_CA_CLIENT_HOME=$PWD/client/acme/peer1
fabric-ca-client enroll -u http://acme-peer1:adminpw@localhost:7054
cp -a $PWD/client/acme/admin/msp/signcerts  $FABRIC_CA_CLIENT_HOME/msp/admincerts

export FABRIC_CA_CLIENT_HOME=$PWD/client/budget/admin
fabric-ca-client register --id.type peer --id.name budget-peer1 --id.secret adminpw --id.affiliation budget
export FABRIC_CA_CLIENT_HOME=$PWD/client/budget/peer1
fabric-ca-client enroll -u http://budget-peer1:adminpw@localhost:7054
cp -a $PWD/client/budget/admin/msp/signcerts  $FABRIC_CA_CLIENT_HOME/msp/admincerts


##############################
# User Enrollments Acme only #
##############################
export FABRIC_CA_CLIENT_HOME=$PWD/client/acme/admin
ATTRIBUTES='"hf.AffiliationMgr=false:ecert","hf.Revoker=false:ecert","app.accounting.role=manager:ecert","department=accounting:ecert"'
fabric-ca-client register --id.type user --id.name mary --id.secret pw --id.affiliation acme --id.attrs $ATTRIBUTES
export FABRIC_CA_CLIENT_HOME=$PWD/client/acme/mary
fabric-ca-client enroll -u http://mary:pw@localhost:7054
cp -a $PWD/client/acme/admin/msp/signcerts  $FABRIC_CA_CLIENT_HOME/msp/admincerts

export FABRIC_CA_CLIENT_HOME=$PWD/client/acme/admin
ATTRIBUTES='"hf.AffiliationMgr=false:ecert","hf.Revoker=false:ecert","app.accounting.role=accountant:ecert","department=accounting:ecert"'
fabric-ca-client register --id.type user --id.name john --id.secret pw --id.affiliation acme --id.attrs $ATTRIBUTES
export FABRIC_CA_CLIENT_HOME=$PWD/client/acme/john
fabric-ca-client enroll -u http://john:pw@localhost:7054
cp -a $PWD/client/acme/admin/msp/signcerts  $FABRIC_CA_CLIENT_HOME/msp/admincerts

export FABRIC_CA_CLIENT_HOME=$PWD/client/acme/admin
ATTRIBUTES='"hf.AffiliationMgr=false:ecert","hf.Revoker=false:ecert","department=logistics:ecert","app.logistics.role=specialis:ecert"'
fabric-ca-client register --id.type user --id.name anil --id.secret pw --id.affiliation acme --id.attrs $ATTRIBUTES
export FABRIC_CA_CLIENT_HOME=$PWD/client/acme/anil
fabric-ca-client enroll -u http://anil:pw@localhost:7054
cp -a $PWD/client/acme/admin/msp/signcerts  $FABRIC_CA_CLIENT_HOME/msp/admincerts

# Shutdown CA
docker-compose -f docker-compose-ca.yaml down

# Setup network config
export FABRIC_CFG_PATH=$PWD/config
configtxgen -outputBlock  ./config/orderer/airline-genesis.block -channelID ordererchannel  -profile AirlineOrdererGenesis
configtxgen -outputCreateChannelTx  ./config/airlinechannel.tx -channelID airlinechannel  -profile AirlineChannel

ANCHOR_UPDATE_TX=./config/airline-anchor-update-acme.tx
configtxgen -profile AirlineChannel -outputAnchorPeersUpdate $ANCHOR_UPDATE_TX -channelID airlinechannel -asOrg AcmeMSP

ANCHOR_UPDATE_TX=./config/airline-anchor-update-budget.tx
configtxgen -profile AirlineChannel -outputAnchorPeersUpdate $ANCHOR_UPDATE_TX -channelID airlinechannel -asOrg BudgetMSP
