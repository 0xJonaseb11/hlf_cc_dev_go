#!/bin/bash

#1. Remove the logs files
rm /opt/explorer/logs/app/*.log  
rm /opt/explorer/logs/console/*.log  
rm /opt/explorer/logs/db/*.log  

cp /home/vagrant/bins/config.json         /opt/explorer/app/platform/fabric/config.json
cp /home/vagrant/bins/explorerconfig.json /opt/explorer/app/explorerconfig.json

cd /opt/explorer/app/persistence/fabric/postgreSQL/db

chmod 755 *.sh

./createdb.sh 






