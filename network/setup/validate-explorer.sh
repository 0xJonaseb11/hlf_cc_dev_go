#!/bin/bash

echo "======Image for explorer ====="
docker images | grep hlf-explorer

echo "======Image for postgres ====="
docker images | grep postgres