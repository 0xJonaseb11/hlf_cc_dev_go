#!/usr/bin/env bash

# New properties in 2.0
# CC2_SEQUENCE, CC2_INIT_REQUIRED

# Sets the environment variables for the chaincode
function usage {
    echo   "Usage: set-chain-env.sh -n name -p path -l lang -v version -C channelId "
    echo   "                        -c constructorParams  -q queryParams -i invokeParams"
    echo   "                        -R  private data collection"
    # removed the -P option for EP
    # new option in 2.0
    echo   "                        -s Sequence number            -I  true | false --init-required "
    echo   "                        -g Signature Policy           -G  Channel Config Policy"
    echo   "                        -R  private data collection   -z  Resets the parameters"
    echo   "                        -e auto | acme | budget | both       Endorsing peers "
    echo   "                        -L log level for chaincode    -S  log level for shim"
    echo   "MUST always specify -l with -p"
    echo   "-l   golang | node | java"
    echo   "-p   Just provide the source folder not full path"
    echo   "     golang   Picked from GOPATH=$GOPATH/src"
    # echo   "     node     Picked from NODEPATH=$NODEPATH"
    # echo   "     java     Picked from JAVAPATH=$JAVAPATH"
    echo   "To check current setup    show-chain-env.sh"
}

# 2.0 Resets the variables
function reset_chaincode_variables {
    echo "Resetting the Chaincode Environment Variables."
    CC_LANGUAGE=golang
    CC_PATH=chaincode_example02
    CC_NAME=gocc
    CC_VERSION="1.0"
    CC_CHANNEL_ID=airlinechannel
    CC_CONSTRUCTOR='{"Args":["init","a","100","b","300"]}'
    CC_QUERY_ARGS='{"Args":["query","b"]}'
    CC_INVOKE_ARGS='{"Args":["invoke","a","b","5"]}'
    CORE_CHAINCODE_ID_NAME='gocc'
    CORE_CHAINCODE_LOGGING_LEVEL=''
    CORE_CHAINCODE_LOGGING_SHIM=''
    CC_PRIVATE_DATA_JSON=''
    CC_ENDORSEMENT_POLICY=""
    CC2_SEQUENCE="1"
    CC2_INIT_REQUIRED="true"
    CC2_PACKAGE_FOLDER="/home/vagrant/packages"
    CC2_SIGNATURE_POLICY=""
    CC2_CHANNEL_CONFIG_POLICY=""
    CC2_ENDORSING_PEERS=""
    INTERNAL_DEV_VERSION="1"
}

# Common location for the generated packages
CC2_PACKAGE_FOLDER=$HOME/packages

DIR="$( which set-chain-env.sh)"
DIR="$(dirname $DIR)"
# echo $DIR
source $DIR/to_absolute_path.sh
# Read the current setup
source   $DIR/cc.env.sh

CC2_ENV_FOLDER="$DIR/env"
mkdir -p $CC2_ENV_FOLDER

if [ "$#" == "0" ]; then
    usage
    echo ""
    cat $DIR/cc.env.sh
    exit 0
fi


# Go through the options
L_SPECIFIED=true
while getopts "G:n:p:v:l:C:c:q:i:L:S:R:P:I:s:g:e:xzh" OPTION; do

    case $OPTION in
    h)
        usage
        exit 0
        ;;
    n)
        # Used for install | instantiate | query | invoke
        export CC_NAME=${OPTARG}
        # Used for dev mode execution
        export CORE_CHAINCODE_ID_NAME=$CC_NAME
        ;;
    p)
        export CC_PATH=${OPTARG}
        if [ "$L_SPECIFIED" == "false" ]; then
            echo "MUST SPECIFY Language with -p !!!"
            exit 1
        fi
        if [ "$CC_LANGUAGE" == "golang" ]; then
            echo "Golang" 1> /dev/null
        elif [ "$CC_LANGUAGE" == "node" ]; then
            CC_PATH=$NODEPATH/$CC_PATH
        elif [ "$CC_LANGUAGE" == "java" ]; then
            CC_PATH=$JAVAPATH/$CC_PATH
        else
            echo "Invalid language :  $CC_LANGUAGE  !!!!"
            exit 0
        fi
        ;;
    l)
        export CC_LANGUAGE=${OPTARG}
        L_SPECIFIED=true
        ;;
    v)
        export CC_VERSION=${OPTARG}
        ;;
    C)  # Channel Id
        export CC_CHANNEL_ID=${OPTARG}
        ;;
    c)
        export CC_CONSTRUCTOR=${OPTARG}
        ;;
    q)
        export CC_QUERY_ARGS=${OPTARG}
        ;;
    i)
        export CC_INVOKE_ARGS=${OPTARG}
        ;;
    L)
        # Controls chaincode Logging Level - used in Dev mode
        export CORE_CHAINCODE_LOGGING_LEVEL=${OPTARG}
        ;;
    S)
        # Controls shim Logging Level - used in Dev mode
        export CORE_CHAINCODE_LOGGING_SHIM=${OPTARG}
        ;;
    R)
        # Takes the Private Data JSON configuration
        # File MUST be available under the CC_PATH
        export CC_PRIVATE_DATA_JSON=${OPTARG}
        ;;
    P)
        # Endorsement policy
        echo "DEPRECATED in Fabric 2.x : Please use --siginature-policy option -g   --channel-config-policy option option -G"
        exit
        export CC_ENDORSEMENT_POLICY=${OPTARG}
        ;;
    
    # CC 2.0 properties 
    s)  
        # Sets up the Sequence number
        export CC2_SEQUENCE=${OPTARG}
        ;;
    I)
        # Sets up the --init-required flag
        export CC2_INIT_REQUIRED=${OPTARG}
        ;;

    g) 
        # Sets up the Signature Policy
        export CC2_SIGNATURE_POLICY
        export CC2_SIGNATURE_POLICY=${OPTARG}
        ;;
        
    G)
        # Sets the channel config Policy
        export CC2_CHANNEL_CONFIG_POLICY
        export CC2_CHANNEL_CONFIG_POLICY=${OPTARG}
        ;;

    e)  # Sets teh endorsing peer option
        CC2_ENDORSING_PEERS=${OPTARG}
        ;;
    z)
        # Reset the cc variables
        reset_chaincode_variables
        ;;
    x)
        # increment the internal - dev version
        INTERNAL_DEV_VERSION=$((INTERNAL_DEV_VERSION+1))
        ;;
    *)
        echo "Incorrect options provided"
        exit 1
        ;;
    esac
done

if [ -z "$CC_LANGUAGE" ]; then
    CC_LANGUAGE=golang
fi



#env | grep CC_ > $DIR/cc.env.sh
echo "# Generated: $(date)"   > $DIR/cc.env.sh
echo "export CC_LANGUAGE=$CC_LANGUAGE" >> $DIR/cc.env.sh
echo "export CC_PATH=$CC_PATH" >> $DIR/cc.env.sh
echo "export CC_NAME=$CC_NAME" >> $DIR/cc.env.sh
echo "export CC_VERSION=$CC_VERSION" >> $DIR/cc.env.sh
echo "export CC_CHANNEL_ID=$CC_CHANNEL_ID" >> $DIR/cc.env.sh
echo "export CC_CONSTRUCTOR='$CC_CONSTRUCTOR'" >> $DIR/cc.env.sh
echo "export CC_QUERY_ARGS='$CC_QUERY_ARGS'" >> $DIR/cc.env.sh
echo "export CC_INVOKE_ARGS='$CC_INVOKE_ARGS'" >> $DIR/cc.env.sh
echo "export CORE_CHAINCODE_ID_NAME='$CORE_CHAINCODE_ID_NAME'" >> $DIR/cc.env.sh
echo "export CORE_CHAINCODE_LOGGING_LEVEL='$CORE_CHAINCODE_LOGGING_LEVEL'" >> $DIR/cc.env.sh
echo "export CORE_CHAINCODE_LOGGING_SHIM='$CORE_CHAINCODE_LOGGING_SHIM'" >> $DIR/cc.env.sh
echo "export CC_PRIVATE_DATA_JSON='$CC_PRIVATE_DATA_JSON'" >> $DIR/cc.env.sh
echo "export CC_ENDORSEMENT_POLICY=\"$CC_ENDORSEMENT_POLICY\"" >> $DIR/cc.env.sh
# 2.0 properties
echo "export CC2_SEQUENCE=\"$CC2_SEQUENCE\"" >> $DIR/cc.env.sh
echo "export CC2_INIT_REQUIRED=\"$CC2_INIT_REQUIRED\"" >> $DIR/cc.env.sh
echo "export CC2_PACKAGE_FOLDER=\"$CC2_PACKAGE_FOLDER\"" >> $DIR/cc.env.sh
echo "export CC2_SIGNATURE_POLICY=\"$CC2_SIGNATURE_POLICY\"" >> $DIR/cc.env.sh
echo "export CC2_CHANNEL_CONFIG_POLICY=\"$CC2_CHANNEL_CONFIG_POLICY\"" >> $DIR/cc.env.sh
echo "export CC2_ENDORSING_PEERS=\"$CC2_ENDORSING_PEERS\"" >> $DIR/cc.env.sh
echo "export CC2_ENV_FOLDER=\"$CC2_ENV_FOLDER\"" >> $DIR/cc.env.sh
echo "export INTERNAL_DEV_VERSION=\"$INTERNAL_DEV_VERSION\"" >> $DIR/cc.env.sh


# if [[ $0 = *"set-chain-env.sh" ]]
# then
#     echo "Did you use the . before set-env.sh? If yes then we are good :)"
# fi
