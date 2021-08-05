FROM squadgoals/core:latest

RUN apt-get update && apt-get install -y \
    openjdk-8-jre-headless

EXPOSE 25565/tcp 25565/udp

RUN mkdir -p /srv/minecraft/
WORKDIR /srv/minecraft
COPY squadgoals_icon_v3.png squadgoals_icon.png

