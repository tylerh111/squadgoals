#!/bin/bash

# This script will run any squadgoals/minecraft docker image
# Input:
#   <1> docker image repo
#   <2> docker image tag    (optional, default="latest")

# check input for docker image repo and tag
image_repo=""
image_tag="latest"

if [[ ! -z $1 ]]; then image_repo=$1; fi
if [[ ! -z $2 ]]; then image_tag=$2; fi

if [[ -z image_repo ]]; then echo "Must supply a docker image repo"; exit 1; fi

echo "Running: $image_repo:$image_tag"
echo "Running command: docker run -p 25565:25565 -dt $image_repo:$image_tag"

docker run -p 25565:25565 -dt $image_repo

