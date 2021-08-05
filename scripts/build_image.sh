#!/bin/bash

# This script will build any docker image
# The built docker image will be tagged with the following:
#   <image_repo>:latest
#   <image_repo>:<image_tag>,
#   <image_repo>:<image_tag>-<current_date>,    e.g. my_image:2021.07.22
# 
# Input:
#   <1> directory containing a docker context (docker/Dockerfile)

# check input for context
if [[ -z $1 ]]; then
    echo "Must supply a path to a image directory"
    exit 1
elif [[ ! -d $1 ]]; then
    echo "'$1' is not a directory"
    exit 2
else
    context=$(realpath --relative-to=$(pwd) $1)
    if [[ ! -d "$context/docker/" ]]; then
        echo "'$context/docker/' does not exist"
        exit 3
    fi
    if [[ ! -f "$context/docker/Dockerfile" ]]; then
        echo "'$context/docker/Dockerfile' does not exist"
        exit 4
    fi
fi

# get image repo and tag
image_repo="squadgoals/$(basename $context)"
if [[ -f "$context/image_repo.txt" ]]; then
    line=$(head -n 1 "$context/image_repo.txt")
    if [[ ! -e $line ]]; then image_repo=$line; fi
fi

image_tag="latest"
if [[ -f "$context/image_tag.txt" ]]; then
    line=$(head -n 1 "$context/image_tag.txt")
    if [[ ! -e $line ]]; then image_tag=$line; fi
fi


# build and tag image
echo "Building $image_repo:$image_tag"
cd $context/docker
docker build . -t $image_repo:build
docker image tag  $image_repo:build $image_repo:"$image_tag"
docker image tag  $image_repo:build $image_repo:"$image_tag-$(date +%Y.%m.%d)"
