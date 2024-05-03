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
vagrant --versionr

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

```

## `Manage lifecycle of chaincode`

```sh
peer lifecycle subcommand --flags || peer chaincode subcommand --flags
# get help on it
peer lifecycle chaincode -h

## Get peers chaincode validated and up runnning
peer lifecycle chaincode queryinstalled

# wait for commit confirmation on the peer
peer lifecycle chaincode command --waitForEvent

# Peer lifecycle chaincode approveFormyorg - all flags
peer lifecycle chaincode approveformyorg -h

# check ther orgs that have approved
peer lifecycle chaincode checkcommitreadiness <--flags> || -h

# Peer lifecycle commit

peer lifecycle chaincode commit <--flags> || -h

# Check commit status
peer lifecycle chaincode querycommitted

# Alternatively, you can check and commit with `chain.sh`
chain.sh commit # commit 
chain.sh querycommitted # status of commit
chain.sh list # list of installed chaincode

# Common lifecycle flags used 
-n -v # Name && version of chaincode
-C --channelID # channel ID
-sequence # sequence number on the CC
--init-required # indicates if initialization is required
--peerAddresses # endorsing peers
-o # Orderer address

# With the accessible main apis
# execute logic - peer
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
```

## `Install chaincode using  'chain.sh'  utility`

```sh
chain.sh install packge_name
# Create a package and install chaincode on it
chain.sh install -p
```

## `Retrieve list of chaincodes installed`

```sh
chain.sh queryinstalled
```

## `Approve chaincode`

```sh
. set-chain-env.sh acme
# Do the approval
chain.sh approveformyorg || chain.sh approve

# show which orgs have approved
chain.sh checkcommitreadiness || chain.sh check

# Chain.sh foe CC instantiation
chain.sh instantiate # approves, commits and inits the chaincode
```

## `set the initialization status`

```sh
set-chain-env.sh -I false || true
```

## `Query and invoke interfaces`

## `query`

```sh
set-chain-env.sh -i # CC_INVOKE_ARGS
# for query 
set-chain-env.sh -q # CC_QUERY_ARGS

# Real query operations
set-chain-env.sh -q '{"Args":["query","a"]}' # set args
chain.sh query # get result
```

## `invoke`

```sh
set-chain-env.sh -i '{"Args":["invoke","a","b","5"]}'
chain.sh invoke
chain.sh query
```

## `With init`

```sh
set-chain-env.sh -C # CC_CONSTRUCTOR

```

## _**`NOTE:: init MUST be executed before Invoke and Query operations`**_

```sh
chain.sh init -o
chain.sh init
```

## `Chaincode update and Upgrade`

```sh
set-chain-env.sh -v <version> # set chaincode version 
# Updating chaincode parameters
set-chain-env.sh -s <sequence_no> # New sequence number
set-chain-env.sh -v <version> # Version of the chaincode
set-chain-env.sh -I <boolean> # Initialization true | false
set-chain-env.sh -g, -G # Specify Endorsement policy
set-chain-env.sh -R # Private data collection
```

trial task

```sh
set-chain-env.sh -v 2.1
set-chain-env.sh -s 4
chain.sh package
chain.sh install
chain.sh approve -o
chain.sh approve
chain.sh commit
```

## `Chain.sh for automatic updates`

```sh
chain.sh upgrade-auto
```

## `Peer launch modes - Net && Dev modes`

```sh
cc-build.sh # Builds the chaincode using: `go build $CC_PATH
cc-run.sh # Runs chaincode with : `go run $GOPATH/src/$CC_PATH/*.go`
```

## `dev mode` - Terminal 1

```sh
# Peer launch dev mode
## Terminal 1
dev-init.sh -d
. set-env.sh acme
set-chain-env.sh
chain.sh install
cc-run.sh 
```

## Terminal 2

```sh
. set-env.sh acme
chain.sh instantiate
chain.sh invoke
chain.sh query
```

## `chaincode logging`

```sh
set-chain-env.sh -L <level> # provided as a string
set-chain-env.sh -S <level> # provided as a string


--------------------

@Jaz-3-0
