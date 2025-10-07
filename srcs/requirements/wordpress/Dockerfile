# Use Alpine as the base image
FROM alpine:3.21.4@sha256:b6a6be0ff92ab6db8acd94f5d1b7a6c2f0f5d10ce3c24af348d333ac6da80685

# RUN \
#     apk add openrc

RUN \
    echo "hi" && \
    apk add openssl curl ca-certificates

RUN printf "%s%s%s%s\n" \
    "@nginx " \
    "http://nginx.org/packages/alpine/v" \
    `egrep -o '^[0-9]+\.[0-9]+' /etc/alpine-release` \
    "/main" \
    | tee -a /etc/apk/repositories

RUN curl -o /tmp/nginx_signing.rsa.pub https://nginx.org/keys/nginx_signing.rsa.pub

# Enable to Verify that downloaded file contains the proper key: 
# RUN openssl rsa -pubin -in /tmp/nginx_signing.rsa.pub -text -noout

RUN mv /tmp/nginx_signing.rsa.pub /etc/apk/keys/
RUN apk add nginx@nginx

COPY index.html /usr/share/nginx/html/index.html

EXPOSE 80

RUN nginx
# Specify the start point of our image
# ENTRYPOINT ["nginx"]
ENTRYPOINT ["tail", "-f"]
