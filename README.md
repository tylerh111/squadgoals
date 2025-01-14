# Squad Goals

Squadgoals is a collection of containerized game servers.
All container images have pre-installed tools for managing game servers, files, etc.

### Minecraft

Minecraft servers use [itzg/minecraft-server](https://hub.docker.com/r/itzg/minecraft-server) images.
See [Minecraft Server on Docker (Java Edition)](https://docker-minecraft-server.readthedocs.io) documentation for more information for working with the server.

Useful commands are listed below.

```bash
docker compose up <service>
```

Available services are listed below.

| Service                    | Name                 | Version  | Minecraft |
|----------------------------|----------------------|----------|-----------|
| `minecraft-1.21.4`         | Minecraft            | 1.21.4   | 1.21.4    |
| `minecraft-ftb-evolution`  | FTB Evolution        | 1.7.0    | 1.21.1    |
| `minecraft-ftb-revelation` | FTB Revelation       | 3.7.0    | 1.12.2    |
