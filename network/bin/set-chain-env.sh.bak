#!/usr/bin/env bash

# Sets the environment variables for the chaincode
function usage {
    echo   "Usage: set-chain-env.sh -n name -p path -l lang -v version -C channelId "
    echo   "                        -c constructorParams  -q queryParams -i invokeParams"
    echo   "                        -L log level for chaincode    -S  log level for shim"
    echo   "                        -P endorsement policy         -R  private data collection"
    echo   "MUST always specify -l with -p"
    echo   "-l   golang | node | java"
    echo   "-p   Just provide the source folder not full path"
    echo   "     golang   Picked from GOPATH=$GOPATH"
    # echo   "     node     Picked from NODEPATH=$NODEPATH"
    # echo   "     java     Picked from JAVAPATH=$JAVAPATH"
    echo   "To check current setup    set-chain-env.sh"
}

DIR="$( which set-chain-env.sh)"
DIR="$(dirname $DIR)"
# echo $DIR
source $DIR/to_absolute_path.sh
# Read the current setup
source   $DIR/cc.env.sh

if [ "$#" == "0" ]; then
   cat $DIR/cc.env.sh
   echo ""
   usage
   exit 0
fi



L_SPECIFIED=true
while getopts "n:p:v:l:C:c:q:i:L:S:R:P:h" OPTION; do
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
        export CC_ENDORSEMENT_POLICY=${OPTARG}
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




# if [[ $0 = *"set-chain-env.sh" ]]
# then
#     echo "Did you use the . before set-env.sh? If yes then we are good :)"
# fi
