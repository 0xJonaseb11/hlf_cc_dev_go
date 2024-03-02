#!/bin/bash
if [ -z $1 ]; then
    FOLDER=console
else 
    FOLDER=$1
fi

ls /opt/explorer/logs/$FOLDER
cat /opt/explorer/logs/$FOLDER/*.log