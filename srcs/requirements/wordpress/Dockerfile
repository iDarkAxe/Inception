# Use Alpine as the base image
FROM alpine:3.21.4@sha256:b6a6be0ff92ab6db8acd94f5d1b7a6c2f0f5d10ce3c24af348d333ac6da80685

ARG WORDPRESS_DB_NAME
ARG WORDPRESS_DB_USER
ARG WORDPRESS_DB_PASSWORD
ARG WORDPRESS_DB_HOST

RUN test -n "$WORDPRESS_DB_NAME" \
	|| (echo "WORDPRESS_DB_NAME should be defined !" && exit 1)
RUN test -n "$WORDPRESS_DB_USER" \
	|| (echo "WORDPRESS_DB_USER should be defined !" && exit 1)
RUN test -n "$WORDPRESS_DB_PASSWORD" \
	|| (echo "WORDPRESS_DB_PASSWORD should be defined !" && exit 1)
RUN test -n "$WORDPRESS_DB_HOST" \
	|| (echo "WORDPRESS_DB_HOST should be defined !" && exit 1)

RUN apk add --no-cache php83-fpm php83-mysqli dumb-init
RUN	sed -i 's/^listen\s*=.*/listen = 0.0.0.0:9000/' /etc/php83/php-fpm.d/www.conf

RUN mkdir -p /website \
	&& cd /website \
	&& wget https://wordpress.org/latest.tar.gz \
	&& tar -xzvf latest.tar.gz \
	&& rm latest.tar.gz

RUN if [ ! -f /website/wordpress/wp-config.php ]; then \
	cp /website/wordpress/wp-config-sample.php /website/wordpress/wp-config.php \
	&& sed -i "s/^define( 'DB_NAME', *'[^']*' );/define( 'DB_NAME', '${WORDPRESS_DB_NAME}' );/" /website/wordpress/wp-config.php \
	&& sed -i "s/^define( 'DB_USER', *'[^']*' );/define( 'DB_USER', '${WORDPRESS_DB_USER}' );/" /website/wordpress/wp-config.php \
	&& sed -i "s/^define( 'DB_PASSWORD', *'[^']*' );/define( 'DB_PASSWORD', '${WORDPRESS_DB_PASSWORD}' );/" /website/wordpress/wp-config.php \
	&& sed -i "s/^define( 'DB_HOST', *'[^']*' );/define( 'DB_HOST', '${WORDPRESS_DB_HOST}' );/" /website/wordpress/wp-config.php; \
	fi

ENTRYPOINT ["dumb-init", "--", "php-fpm83", "-F"]
