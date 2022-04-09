FROM squadgoals/core:latest

RUN apt-get update && apt-get install -y \
    openjdk-8-jre-headless

RUN useradd -u 1000 -U -s /bin/bash -m minecraft && \
    cp /root/.bashrc /home/minecraft/.bashrc

USER minecraft

WORKDIR /minecraft

EXPOSE 25565/tcp 25565/udp

