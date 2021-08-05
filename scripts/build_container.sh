#!/bin/bash

# This script will build any docker image
# The built docker image will be tagged with the following:
#   <image_repo>:<image_tag>
# 
# Input:
#   <1> directory containing
#       - docker context (docker/Dockerfile)
#       - docker-compose file
#   <2> project name
#       - environment file is interpolated from project name

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
    if [[ ! -f "$context/docker-compose.yaml" ]]; then
        echo "'$context/docker-compose.yaml' does not exist"
        exit 4
    fi
fi

# check input for project name
if [[ -z $2 ]]; then
    echo "Must supply a project name"
    exit 5;
else
    project=$2
    env_file=$2.yaml
    if [[ ! -f "$context/$env_file" ]]; then
        echo "$context/$env_file does not exist"
        exit 6
    fi
fi


# build image and build container
cd $context
docker-compose --env-file $2.env -p $2 up --no-start

