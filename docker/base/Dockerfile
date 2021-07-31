FROM ubuntu:focal

RUN apt-get update && apt-get install -y \
    tmux curl vim less \
    openjdk-8-jre-headless

RUN mkdir -p \
    /srv/minecraft/images/ \
    /srv/minecraft/mods/ \
    /srv/minecraft/servers/

COPY .bashrc /root/
COPY squadgoals_icon_v3.png /srv/minecraft/squadgoals_icon.png

# expose the ports
EXPOSE 25565/tcp 25565/udp

