# Use Alpine as the base image
FROM alpine:3.21.4@sha256:b6a6be0ff92ab6db8acd94f5d1b7a6c2f0f5d10ce3c24af348d333ac6da80685

RUN apk add --no-cache php83-fpm php83-mysqli php83-session dumb-init
RUN	sed -i 's/^listen\s*=.*/listen = 0.0.0.0:9000/' /etc/php83/php-fpm.d/www.conf

RUN mkdir -p /website \
	&& cd /website \
	&& wget https://wordpress.org/latest.tar.gz \
	&& tar -xzvf latest.tar.gz \
	&& rm latest.tar.gz

RUN wget https://github.com/vrana/adminer/releases/download/v5.4.1/adminer-5.4.1.php \
	&& mv adminer-5.4.1.php /website/wordpress/adminer.php

COPY main.sh /main.sh
RUN chmod +x /main.sh

ENTRYPOINT ["dumb-init", "--", "/main.sh"]
