#!/bin/bash

# Installs the images for explorer

# Remove older version if there is one
docker rmi acloudfan/hlf-explorer  &>  /dev/null

echo "====> Pulling image for explorer ===="
docker pull acloudfan/hlf-explorer

# Remove older version if there is one
docker rmi postgres:9.5   &>  /dev/null

echo "====> Pulling image for postgres ===="
docker pull postgres:9.5

echo "Done."
