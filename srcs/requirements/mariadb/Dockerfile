# Use Alpine as the base image
FROM alpine:3.22.1@sha256:4bcff63911fcb4448bd4fdacec207030997caf25e9bea4045fa6c8c44de311d1

# Copy the main shell script to image
COPY ["main.sh", "/usr/local/bin/"]

RUN \
    # Add MariaDB packages
    apk add --no-cache \
        mariadb \
        mariadb-client; \
    # Give execute permission to main.sh
    chmod +x /usr/local/bin/main.sh

# Specify the start point of our image
ENTRYPOINT ["main.sh"]
