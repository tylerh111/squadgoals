FROM squadgoals/minecraft/base:latest

# feed-the-beast server installer
ADD https://api.modpacks.ch/public/modpack/80/2053/server/linux  /srv/minecraft/images/ftb_serverinstall
RUN chmod +x /srv/minecraft/images/ftb_serverinstall

# id: ftb endeavour 1.4.0 : 80.2053
RUN /srv/minecraft/images/ftb_serverinstall 80 2053 --auto --verbose \
    --path /srv/minecraft/servers/ftb_endeavour_80_2053/

WORKDIR /srv/minecraft/servers/ftb_endeavour_80_2053/
RUN echo "eula=true" > eula.txt

