#!/bin/bash

LAUNCHDIR="/home/steam/rust_server"
STEAMCMD="/home/steam/steamcmd.sh"

update_rust() {
    if test -f "$STEAMCMD"; then
        $STEAMCMD +login anonymous +force_install_dir /home/steam/rust_server +app_update 258550 validate +quit
    fi
}

start_server() {
    cd $LAUNCHDIR
    $LAUNCH/RustDedicated ${STARTUP_ARGS} +server.worldsize ${SERVER_WORLDSIZE} +server.seed ${SERVER_SEED} +server.maxplayers ${SERVER_MAXPLAYERS} +server.port ${SERVE_PORT} +server.saveinterval ${SERVER_SAVE_INTERVAL}
}

update_rust()
start_server()
