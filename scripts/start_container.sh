#!/bin/bash

# This script will run any squadgoals/minecraft docker image
# Input:
#   <1> docker container name

# check input for docker image repo and tag
container_name=""

if [[ ! -z $1 ]]; then container_name=$1; fi

if [[ -z container_name ]]; then echo "Must supply a docker image repo"; exit 1; fi

echo "Running: $container_name"
echo "Running command: docker start -ai $container_name"

docker start -ai $container_name

