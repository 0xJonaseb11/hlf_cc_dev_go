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

--------------------

@Jaz-3-0
