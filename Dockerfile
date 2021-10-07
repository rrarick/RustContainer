FROM cm2network/steamcmd:latest

# Fix apt-get warnings
ARG DEBIAN_FRONTEND=noninteractive

# INSTALL AS ROOT
USER root

# Install dependencies
# TODO: Fix App Errors
RUN apt-get update && \
    apt-get full-upgrade -y --no-install-recommends && \
    apt-get install -y --no-install-recommends \
        sqlite3 && \
    rm -rf /var/lib/apt/lists/*

# SWITCH BACK TO NONROOT
USER steam
WORKDIR /home/steam/steamcmd

VOLUME ["/home/steam/rust_server"]


# Move this to SH script
# RUNNING HERE IS BAD
RUN ./steamcmd.sh +login anonymous +force_install_dir /home/steam/rust_server +app_update 258550 validate +quit

ENV SERVE_PORT "28015"
#ENV RCON_PORT "28016"
#ENV APP_PORT ""
# Expose ports
# TODO: RCON
EXPOSE ${SERVE_PORT}
#EXPOSE ${RCON_PORT}
#EXPOSE ${APP_PORT}

# Setup default environment variables
ENV STARTUP_ARGS "-batchmode -load -nographics +server.secure 0 +server.encryption 0"
ENV SERVER_SEED "12345"
#ENV SERVER_NAME "Rust Server [DOCKER]"
#ENV SERVER_DESCRIPTION "This is a Rust server running inside a Docker container!"
#ENV SERVER_URL ""
#ENV SERVER_BANNER_URL ""
#ENV START_MODE "0"
ENV SERVER_WORLDSIZE "3500"
ENV SERVER_MAXPLAYERS "10"
ENV SERVER_SAVE_INTERVAL "600"

WORKDIR /home/steam/rust_server

# Start the server
#TODO: MOVE TO SH script
ENTRYPOINT [ "RustDedicated", "${STARTUP_ARGS}", "+server.worldsize ${SERVER_WORLDSIZE}", "+server.seed ${SERVER_SEED}", "+server.maxplayers ${SERVER_MAXPLAYERS}", "+server.port ${SERVE_PORT}", "+server.saveinterval ${SERVER_SAVE_INTERVAL}" ]
CMD [ "bash"]
