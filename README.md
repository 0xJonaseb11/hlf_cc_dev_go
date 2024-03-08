# Hyperledger_chaincode_dev

_**Author: @Jaz-3-0**_

## About

Master and interact with Hyperledger chain code development using Go Lang

Hyperledger Fabric is a platform for distributed ledger solutions, underpinned by a modular architecture delivering high degrees of confidentiality, resiliency, flexibility and scalability. It is designed to support pluggable implementations of different components, and accommodate the complexity and intricacies that exist across the economic ecosystem.

Hyperledger Fabric delivers a uniquely elastic and extensible architecture, distinguishing it from alternative blockchain
solutions

## Getting started

- Install
  
  - curl
  - docker LTS
  - docker compose LTS (install with docker)
  - Go LTS
  - Node.js LTS
  
## `Check for installed`

```sh
docker --version
docker-compose --version
curl --version
orderer version
peer version
go --version
vagrant --version

 ```

 ```sh
 # validate go-tools
 govendor -h
 # validate fabric
 ./validate-fabric.sh
 # validate git-repo updates
 ./validate-git-repo.sh
 # validate prerequisites
 ./validate-prereqs.sh
 # validate setup
 ./validate-setup.sh
 # validate hyperledger explorer
 ./validate-explorer.sh
# validate node
node -v

 ```

## `Update git repo`

 ```sh
 ./update-git-repo.sh
 ```

### `Install dependencies`

```sh
vagrant up
vagrant ssh
cd network/setup

# install prerequisites
./install-preqs.sh
# install hyperledger explorer
./install-explorer.sh
# install fabric
./install-fabric.sh
# install nodejs utilities
./install-node-utils.sh

```

## `Development scripts`

```sh
vagrant ssh
cd network/bin
# initialize and launch dev setup
./dev-init.sh
# validate the dev environment
./dev-validate.sh
# stop containers -> (non-destructive)
./dev.stop.sh
# start the stopped containers
./dev-start.sh
# check the launch mode for the env (dev|net)
./dev-mode.sh
```

## `Validate container health`

```sh
docker ps
```

## `Environment setup scrupts`

```sh
vagrant ssh
# set environement variables for peer binary
set-env.sh
# shows the values set in environment variables
show-env.sh
```

## `Set up the organisation context`

```sh
source set-env.sh  acme | budget # in source
. set-env.sh  acme | budget # .
```

## `Getting the organisation context`

```sh
# print the current env context setup
show-env.sh
```

## `Channel commands`

```sh
# peer channel help
peer channel --help
# List the channels peer has joined
peer channel list
# Get info about the blockchain
peer channel getinfo -c airlinechannel


## Manage lifecycle of chaincode
peer lifecycle subcommand --flags || peer chaincode subcommand --flags
# get help on it
peer lifecycle chaincode -h

## Get peers chaincode validated and up runnning
peer lifecycle chaincode queryinstalled

# With the accessible main apis
execute logic - peer
peer chaincode invoke
# Read blockchain state
peer chaincode query

## With older versions of fabric ( below 2.x)
peer chaincode install
peer chaincode upgrade
peer chaincode instantiate
```

## `Working with hyperledger explorer`

```sh
# Reset the explorer runtime
exp-init.sh -e
# Stop the running explorer containers
exp-stop.sh
# Restart the explorer containers
exp-start.sh  
```

## `Chaincode development scripts`

```sh
# Execute peer chaincode commands
chain.sh
# set environemt variables for chaincode arguments || With no flags displays the current setup
set-chain-env.sh
# Access the command arguments in Environent variables
cc.env.sh
# Show all the envoronemt variables set using `set-chain-env.sh`
show-chain-env.sh
# Reset chaincode environment
reset-chain-env.sh

## Let's try to change the name of the chaincode
set-chain-env.sh -n new_chaincode_name

# Query the peer and get the instant chaincode from it
chain.sh queryinstalled
# Query the gocc chaincode installed at my peer
chain.sh query
# Let's get the command the chain.sh will execute
chain.sh querycommitted -o

## Get every list of flags
set-chain-env.sh -h

```

## `Peer lifecycle package installation`

```sh
peer lifecycle package tar-file --flags
# Important flags to consider
--peerAddress -> Target peer(multiple may be specified)
--label -> Label for the chaincode
-p -> path for the chaincode

# Once you don't specify the path, it will beinstalled at
$ CORE_PEER_ADDRESS

# Install chaincode using `chain.sh` utility
```sh
chain.sh install packge_name
# Create a package and install chaincode on it
chain.sh install -p
```

## `Retrieve list of chaincodes installed`

```sh
chain.sh queryinstalled

--------------------

@Jaz-3-0
