#!/bin/bash
nc -z localhost 8080

# 0=success 1=failure
echo $?