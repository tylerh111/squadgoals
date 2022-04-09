
## Squadgoals: Minecraft

Requires:
 * squadgoals/core

Build images:
```
$ docker build -t squadgoals/minecraft:latest .
```

Run containers:
```bash
$ docker run -it -p 25565:25565 -v <server_location>:/minecraft squadgoals/minecraft /bin/bash
(container) $ ./serverinstall <modpackid> <versionid> # only necessary for ftb
(container) $ ./start.sh # might be startserver.sh
```

Note, the server must be located at `<server_location>` and it must be binded to `/minecraft`.
The docker image should have all the packages necessary to install a fresh server using an install script (such as FTB's serverinstall).
The `/minecraft` folder is the current working directory when starting the server.
If nothing is bound to that folder, it will appear empty.

