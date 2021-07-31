FROM squadgoals/minecraft/base:latest

# feed-the-beast server installer
ADD https://api.modpacks.ch/public/modpack/35/2059/server/linux  /srv/minecraft/images/ftb_serverinstall
RUN chmod +x /srv/minecraft/images/ftb_serverinstall

# id: ftb revelation 3.5.0: 35.2059
RUN /srv/minecraft/images/ftb_serverinstall 35 2059 --auto --verbose \
    --path /srv/minecraft/servers/ftb_revelation_35_2059/

WORKDIR /srv/minecraft/servers/ftb_revelation_35_2059/
RUN echo "eula=true" > eula.txt

