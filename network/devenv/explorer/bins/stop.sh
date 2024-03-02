#!/bin/bash

cd /opt/explorer

export DATABASE_HOST=postgresql

./stop.sh
./syncstop.sh

