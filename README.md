# Squad Goals

This repository contains dockerfiles for creating docker wrappers for servers.
The goal of these images is to have the necessary tools installed to run servers, such as minecraft servers.
Server files are stored on the host filesystem, but are access via the docker container through volume binding.

## Getting started

Install docker-ce for your OS/Distro.

Refer to the README.md in each instructions on how to build and run the docker images.

## Docker Images

Docker containers startup in a tmux server.
This allows users to attach to the server's session after detach/stopping the container.
Use `C-b d` to detach from the tmux session.
Use `tmux attach -t main` to reattach to the tmux session running the server.
Refer to the end of `docker/base/.bashrc` for more information.

Users may want to detach from the container after starting the server.
Use `C-p C-q` to detach from the container
Use `docker attach <container>`.
The container name varies, so use `docker ps` to show the running containers. 

