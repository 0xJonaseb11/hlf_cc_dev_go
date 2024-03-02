#!/bin/bash

# Updated April 2020 - for Fabric 2.0

# Stop execuion if there is an error
# set -e

# This is so we can use the functions in chain.sh
source chain.sh  &> /dev/null

# Used for console printling
FAILED_SYMBOL='\U274C   Failed:'
PASSED_SYMBOL='\U2705  Success:'
INFO_SYMBOL='\U1F6C8  [utest]'
PANIC_SYMBOL='\U2620  '
TEST_CASE_SYMBOL='\U1F535   Test Case: '


# Default time for transactions
export TXN_WAIT_TIME=1s

# Installs the requested 
function  chain_install {
    if [ "$UTEST_DEV_MODE" == "dev" ]; then
        print_utest_info  "Ignored 'chain_install' ... Run chaincode on command prompt"
        return
    fi
    print_utest_info  "Installing..."
    # 2.0 change
    # peer chaincode install -l "$CC_LANGUAGE" -n "$CC_NAME" -p "$CC_PATH" -v "$CC_VERSION"
    # chain.sh install -p
    cc_pinstall
    INSTALL_RESULT=$?

    # update the package-id
    get-package-id.sh -n $CC_NAME -v $CC_VERSION
    source $CC2_ENV_FOLDER/get-package-id
}

# Installs the requested 
function  chain_instantiate {
    if [ "$UTEST_DEV_MODE" == "dev" ]; then
        print_utest_info  "Ignored 'chain_instantiate' ... Instantiate chaincode on command prompt"
        return
    fi
    print_utest_info  "Instantiating..."
    # 2.0 change
    # peer chaincode instantiate -C "$CC_CHANNEL_ID" -n "$CC_NAME" -v "$CC_VERSION" -c "$CC_CONSTRUCTOR"  -o "$ORDERER_ADDRESS" -l "$CC_LANGUAGE"
    # chain.sh instantiate
    cc_instantiate

    INSTALL_RESULT=$?
    # wait for some time
    txn_sleep
}

# Approve for the org
function  chain_approveformyorg {
    cc_approveformyorg
}

# Generate unique name
# Uses the existing CC_NAME and suffixes it with a random string
function generate_unique_cc_name {

    if [ "$UTEST_DEV_MODE" == "dev" ]; then
        print_utest_info  "Ignored 'generate_unique_cc_name' Using CC_NAME = '$CC_NAME' "
        return
    fi

    RAND_STR=$( echo $RANDOM | tr '[0-9]' '[a-zA-Z]')
    export CC_NAME="$CC_NAME-$RAND_STR"
    print_utest_info  "Setting CC_NAME = '$CC_NAME' "
}

# Sets the organization context
# $1 = org name e.g., acme | budget
# Does not check the correctness
function set_org_context {
    print_utest_info  "Switching Org Context to $1"
    source set-env.sh "$1"
    CC2_ENDORSING_PEERS=$CORE_PEER_ADDRESS
}

# Invokes the function
# Aborts if there is an error - otherwise sleeps for default txn time
function   chain_invoke {
    print_utest_info  "Invoking...peer chaincode invoke -C $CC_CHANNEL_ID -n $CC_NAME  -c '$CC_INVOKE_ARGS' --waitForEvent"

    # export INVOKE_RESULT=$(peer chaincode invoke -o "$ORDERER_ADDRESS" -C "$CC_CHANNEL_ID" -n "$CC_NAME"  -c "$CC_INVOKE_ARGS")
    peer chaincode invoke -o "$ORDERER_ADDRESS" -C "$CC_CHANNEL_ID" -n "$CC_NAME"  -c "$CC_INVOKE_ARGS"  --waitForEvent

    # wait for some time
    txn_sleep
} 

# Query function
# $1 [Optional] = JQ Filter
function   chain_query  {
    print_utest_info  "Querying...peer chaincode query -C $CC_CHANNEL_ID -n $CC_NAME  -c $CC_QUERY_ARGS"

    # echo $CC_QUERY_ARGS
    
    QUERY_RESULT=$(peer chaincode query -C "$CC_CHANNEL_ID" -n "$CC_NAME"  -c "$CC_QUERY_ARGS")
    
    if [ "$1" = "" ]; then
        export QUERY_RESULT
    else 
        extract_json "$QUERY_RESULT"  "$1"
        export QUERY_RESULT=$EXTRACT_RESULT
    fi

    export QUERY_RESULT_CODE=$?
}

# Assert equal
# $1=VALUE1   $2VALUE2
function assert_equal {
    VALUE1=$1
    VALUE2=$2
    if [ "$VALUE1" == "$VALUE2" ]; then
        printf "$PASSED_SYMBOL  $TEST_CASE\n"
    else
        printf "$FAILED_SYMBOL  $TEST_CASE\n" 
    fi
}

# Takes a $1="true" | "false" as argument
function  assert_boolean {
    if [ "$1" == "true" ]; then
        printf "$PASSED_SYMBOL  $TEST_CASE\n"
    elif [ "$1" == "false" ]; then
        printf "$FAILED_SYMBOL  $TEST_CASE\n"
    else
        printf "$PANIC_SYMBOL    Invalid value specified = $1!!!\n"
        exit 1
    fi
}

# Takes 2 JSON strings & 1 Json Path
# $1=JSON_STRING $2=JSON_PATH $3=VALUE
function assert_json_equal {
    validate_json   "$1"
    # echo "$1    $2"
    extract_json "$1" "$2"
    # echo $EXTRACT_RESULT
    if [ "$?" = "0" ]; then
        assert_equal "$EXTRACT_RESULT"   "$3"
    else
        echo "$PANIC_SYMBOL    Invalid JSON!!!"
    fi
}

# Just opposite of assert_equal
function assert_not_equal {
    VALUE1="$1"
    VALUE2="$2"

    if  [ "$VALUE1" = "$VALUE2" ]; then
        printf "$FAILED_SYMBOL  $TEST_CASE\n"
    else
        printf "$PASSED_SYMBOL  $TEST_CASE\n"
    fi
}

# Compares the numbers 
function assert_number {
    VALUE1="$1"
    VALUE2="$3"
    OPERATION="$2"   # -eq  -lt  -le   -gt    -ge  -ne

    if  [ $VALUE1 $OPERATION $VALUE2 ]; then
        printf "$PASSED_SYMBOL  $TEST_CASE\n"
    else
        printf "$FAILED_SYMBOL  $TEST_CASE\n"
    fi
}

# Subtracts $1 from $2 & compares with $3
function assert_number_difference {
    VALUE1=$1
    VALUE2=$2
    DIFFERENCE=$(($VALUE2 - $VALUE1))
    assert_number $DIFFERENCE "-eq"  $3
}

# Sets the name of the test case
# $1 = Description of the test case
function    set_test_case {
    export TEST_CASE="$1"
    # print_utest_info "Testcase: $1"
    printf "\n$TEST_CASE_SYMBOL  $TEST_CASE\n"
    
}

# Make the thread sleep 
# $1=sleep time e.g., 5s
function    txn_sleep {
    if [ -z $1 ]; then
        sleep $TXN_WAIT_TIME
    else
        sleep $1
    fi
}

# Strips the leading/ending quote
# Pass the string in $1 
# "test" =>  test   "test\"inner" => test"inner
function strip_quotes {
    opt=$1
    temp="${opt%\"}"
    temp="${temp#\"}"
    export STRIP_QUOTES_RESULT="$temp"
}

#  Extracts the desired value from json
#  $1=JSON  $2=JSON Path  e.g., response.balance
#  Use this as utility for extracting data from JSON
#  EXTRACT_RESULT
function extract_json {
    
    validate_json "$1"

    
    EXTRACT_RESULT=$(echo "$1" | jq  "$2"  )

    # Strip the quotes
    strip_quotes $EXTRACT_RESULT
    EXTRACT_RESULT="$STRIP_QUOTES_RESULT"

    export EXTRACT_RESULT
}

# Function simply validates the JSON
# $1 = JSON to be validates
function validate_json {
    CHECK_JSON=$(echo "$1" | jq 'type')
    # echo "CHECK_JSON=$CHECK_JSON"
    if [ "$CHECK_JSON" != "" ]; then
        echo "JSON is good"  &> /dev/null
    else
        echo "$PANIC_SYMBOL    Bad JSON!!!"
    fi
}

# Used for printing info messages
function    print_utest_info {
    export UTEST_VERSBOSE='true'
    if [ $UTEST_VERSBOSE ]; then
        printf "\t$INFO_SYMBOL $1 \n"
    fi
}

# Print information messages
function    print_info {
    printf "\t \U03A3  [Test]  $1 \n"
}

# Print failure message
function    print_failure {
    printf "\t $PANIC_SYMBOL[Test]  $1 \n"
}



#  UNIT TEST for this script
if [ "$1" == "utest" ]; then
    # Test the assert_equal
    set_test_case   "Test assert_equal if '100'='100'"
    assert_equal    "100"   "100"

    # Test the assert_not_equal
    set_test_case   "Test assert_not_equal if '100'!= '500'"
    assert_not_equal    "100"   "500"
    
    # Set the org context to Acme
    set_test_case   "Test set_org_context for 'acme'"
    set_org_context "acme"
    assert_equal    "acme"  $ORGANIZATION_CONTEXT

    # Set the org context to Acme
    set_test_case   "Test set_org_context for 'budget'"
    set_org_context "budget"
    assert_equal    "budget"  $ORGANIZATION_CONTEXT

    # Test extract_json
    JSON='{"Args":["init","ACFT","1000", "A Cloud Fan Token!!!","raj"]}'
    FILTER='.Args[2]'
    set_test_case   "Test extract_json  EXTRACT_RESULT should be 1000 "
    extract_json   "$JSON"  "$FILTER"
    assert_equal   "$EXTRACT_RESULT"   "1000"

    # Test assert_json_equal
    set_test_case   "Test assert_json_equal $FILTER Should be 1000 "
    assert_json_equal  "$JSON" " $FILTER"   "1000"

    # Test for randomness
    echo "Test Randomness | Uniqueness"
    for i in {1..5}
    do
        CC_NAME='test'
        generate_unique_cc_name 
    done
    
    # Validate JSON
    JSON='{"test":"fine"}'
    # validate_json "$JSON"
    
fi

source dev-mode.sh

UTEST_DEV_MODE=$PEER_MODE

