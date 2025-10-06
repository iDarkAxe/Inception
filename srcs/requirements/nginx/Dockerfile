# Use Alpine as the base image
FROM alpine:3.22.1@sha256:4bcff63911fcb4448bd4fdacec207030997caf25e9bea4045fa6c8c44de311d1

COPY nginx.conf /etc/nginx/nginx.conf
COPY start.sh /start.sh
# COPY index.html /data/www/index.html
COPY docs/ /data/www/

RUN apk update && apk upgrade && \
    apk add --no-cache nginx openssl dumb-init

RUN chmod +x /start.sh

RUN apk add --no-cache git \
    && git clone --depth 1 --filter=blob:none --sparse https://github.com/iDarkAxe/Minishell.git /tmp/minishell \
    && cd /tmp/minishell \
    && git sparse-checkout set docs \
    && mv docs /data/www/ \
    && rm -rf /tmp/minishell \
    && apk del git

# Default HTTP port
EXPOSE 80

# Default HTTPS port
EXPOSE 443

# Specify the start point of our image
ENTRYPOINT ["/start.sh"]
