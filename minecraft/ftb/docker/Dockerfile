FROM squadgoals/minecraft-core:latest
ARG MODPACK_ID
ARG VERSION_ID

COPY serverinstall serverinstall_${MODPACK_ID}_${VERSION_ID}
RUN chmod +x serverinstall_${MODPACK_ID}_${VERSION_ID} ; echo "eula=true" > eula.txt

