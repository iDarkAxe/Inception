# Use Alpine as the base image
FROM alpine:3.21.4@sha256:b6a6be0ff92ab6db8acd94f5d1b7a6c2f0f5d10ce3c24af348d333ac6da80685

COPY nginx.conf /etc/nginx/nginx.conf
COPY start.sh /start.sh
COPY index.html /data/www/index.html

RUN apk update && apk upgrade && \
    apk add --no-cache nginx openssl dumb-init

RUN openssl req -new -newkey rsa:4096 -nodes \
    -keyout nginx.key -out nginx.crt \
    -subj "/C=FR/ST=Rhone/L=Lyon/O=Dis/CN=ppontet.42.fr" \
    && apk del openssl

RUN mv nginx.key /etc/ssl/nginx/nginx.key
RUN mv nginx.crt /etc/ssl/nginx/nginx.crt

RUN chmod +x /start.sh

# Default HTTP port : automatically redirect on https port
# EXPOSE 80

# Default HTTPS port
EXPOSE 443

# Specify the start point of our image
ENTRYPOINT ["/start.sh"]
