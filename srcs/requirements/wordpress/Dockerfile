# Use Alpine as the base image
FROM alpine:3.21.4@sha256:b6a6be0ff92ab6db8acd94f5d1b7a6c2f0f5d10ce3c24af348d333ac6da80685

# Copy the main shell script to image
# COPY ["main.sh", "/usr/local/bin/"]

RUN apk add php-fpm

RUN mkdir -p /website && \
    cd /website && \
    wget https://wordpress.org/latest.tar.gz && \
    tar -xzvf latest.tar.gz && \
    rm latest.tar.gz

# RUN \
    # Give execute permission to main.sh
    # chmod +x /usr/local/bin/main.sh

RUN php-fpm83

ENTRYPOINT ["tail", "-f", "/dev/urandom"]
