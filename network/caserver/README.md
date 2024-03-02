If you get a message that certs have expired execute the script:

./init.sh

ca-dev-init.sh


export FABRIC_CFG_PATH=$PWD/config
configtxgen -outputBlock  ./config/airlinegenesis.block -channelID ordererchannel  -profile AirlineOrdererGenesis
configtxgen -outputCreateChannelTx  ./config/airlinechannel.tx -channelID airlinechannel  -profile AirlineChannel