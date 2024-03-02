#!/bin/bash
# $1 = Identity
DIR="$( which $BASH_SOURCE)"
DIR="$(dirname $DIR)"

source $DIR/to_absolute_path.sh

to-absolute-path $DIR
DIR=$ABS_PATH

CRYPTO_FOLDER=$DIR/../caserver
export CORE_PEER_MSPCONFIGPATH=$CRYPTO_FOLDER/client/$ORGANIZATION_CONTEXT/$1/msp

echo "CORE_PEER_MSPCONFIGPATH = $CORE_PEER_MSPCONFIGPATH"