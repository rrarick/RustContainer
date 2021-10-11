#!/bin/bash

LAUNCHDIR="/home/steam/rust_server"
STEAMCMD="/home/steam/steamcmd/steamcmd.sh"

$STEAMCMD +login anonymous +force_install_dir /home/steam/rust_server +app_update 258550 +quit;
cd $LAUNCHDIR;
exec $LAUNCHDIR/RustDedicated ${STARTUP_ARGS} +server.worldsize ${SERVER_WORLDSIZE} +server.seed ${SERVER_SEED} +server.maxplayers ${SERVER_MAXPLAYERS} +server.port ${SERVE_PORT} +server.saveinterval ${SERVER_SAVE_INTERVAL};
