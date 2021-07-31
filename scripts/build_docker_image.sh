#!/bin/bash

# This script will build any docker iamge
# The built docker image will be tagged with the following:
#   <image_repo>:latest
#   <image_repo>:<current_date>,    e.g. my_image:2021.07.22
# 
# Input:
#   <1> directory containing a Dockerfile

# check input for docker context
if [[ -z $1 ]]; then
    echo "Must supply a directory containing a Dockerfile"
    exit 1
elif [[ ! -d $1 ]]; then
    echo "'$1' is not a directory"
    exit 2
else
    docker_context=$(realpath --relative-to=$(pwd) $1)
    if [[ ! -f "$docker_context/Dockerfile" ]]; then
        echo "'$docker_context/Dockerfile' does not exist"
        exit 3
    fi
fi

# get image repo and tag
image_repo="squadgoals/minecraft/$(basename $docker_context)"
if [[ -f "$docker_context/docker_repo.txt" ]]; then
    line=$(head -n 1 "$docker_context/docker_repo.txt")
    if [[ ! -e $line ]]; then image_repo=$line; fi
fi

image_tag="latest"
if [[ -f "$docker_context/docker_tag.txt" ]]; then
    line=$(head -n 1 "$docker_context/docker_tag.txt")
    if [[ ! -e $line ]]; then image_tag=$line; fi
fi

# enter docker context
cd $docker_context
echo "Entering $docker_context/"
echo "Building $image_repo"

# build and tag image
docker build . -t $image_repo:latest
docker image tag  $image_repo:latest $image_repo:$image_tag
docker image tag  $image_repo:latest $image_repo:$(date +%Y.%m.%d)
