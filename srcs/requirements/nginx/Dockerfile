# Use Alpine as the base image
FROM alpine:3.22.1@sha256:4bcff63911fcb4448bd4fdacec207030997caf25e9bea4045fa6c8c44de311d1

COPY nginx.conf /etc/nginx/nginx.conf
COPY start.sh /start.sh
COPY index.html /var/www/index.html

# Reduce layers number by combining commands
RUN apk update && apk upgrade && \
    apk add --no-cache nginx openssl dumb-init
RUN chmod +x /start.sh

# More layers but better granularity
# RUN apk update
# RUN apk upgrade
# RUN apk add --no-cache nginx openssl dumb-init
# RUN chmod +x /start.sh

EXPOSE 80
EXPOSE 443

# Specify the start point of our image
ENTRYPOINT ["/start.sh"]
