# Squad Goals

This repository contains the docker build files for my minecraft server. The goal of these images is to have a basic server ready to start with a simple start server script. Users will be able to spin up a docker container (with the necessary ports open) with full access to the container's filesystem. This is done on purpose for the sake of accessing the config files directly.

## Getting started

Install docker-ce for your OS/Distro.

Run the helper script to build docker images
```
$ ./scripts/build_docker_image.sh <directory contain docker file>
```

## Docker Images

Run the helper script to build the docker images. The base images, `squadgoals/minecraft/base` is required for all images. It installs all necessary packages and sets configuration files for the root.

The image uses tmux to run the server. This allows users to attach to the server's session after detach/stopping the container. Use `C-b d`to detach from the tmux session. Enter the command `tmux attach -t main` to reattach to the tmux session running the server.

Refer to the end of `docker/base/.bashrc` for more information.

