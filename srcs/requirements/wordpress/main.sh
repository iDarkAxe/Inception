#!/bin/ash

set -eu

# Check that VARS are not empty and write a message if empty
: "${WORDPRESS_DB_NAME:?WORDPRESS_DB_NAME not set}"
: "${WORDPRESS_DB_USER:?WORDPRESS_DB_USER not set}"
: "${WORDPRESS_DB_PASSWORD:?WORDPRESS_DB_PASSWORD not set}"
: "${WORDPRESS_DB_HOST:?WORDPRESS_DB_HOST not set}"
: "${URL:?URL not set}"
: "${WORDPRESS_ADMIN_USERNAME:?WORDPRESS_ADMIN_USERNAME not set}"
: "${WORDPRESS_ADMIN_PASSWORD:?WORDPRESS_ADMIN_PASSWORD not set}"
: "${WORDPRESS_ADMIN_EMAIL:?WORDPRESS_ADMIN_EMAIL not set}"
: "${WORDPRESS_BASIC_USER_USERNAME:?WORDPRESS_BASIC_USER_USERNAME not set}"
: "${WORDPRESS_BASIC_USER_PASSWORD:?WORDPRESS_BASIC_USER_PASSWORD not set}"
: "${WORDPRESS_BASIC_USER_EMAIL:?WORDPRESS_BASIC_USER_EMAIL not set}"

# Si wp-config.php n’existe pas encore, le créer
if [ ! -f /website/wordpress/wp-config.php ]; then
    cp /website/wordpress/wp-config-sample.php /website/wordpress/wp-config.php

    sed -i "s/^define( 'DB_NAME', *'[^']*' );/define( 'DB_NAME', '${WORDPRESS_DB_NAME}' );/" /website/wordpress/wp-config.php
    sed -i "s/^define( 'DB_USER', *'[^']*' );/define( 'DB_USER', '${WORDPRESS_DB_USER}' );/" /website/wordpress/wp-config.php
    sed -i "s/^define( 'DB_PASSWORD', *'[^']*' );/define( 'DB_PASSWORD', '${WORDPRESS_DB_PASSWORD}' );/" /website/wordpress/wp-config.php
    sed -i "s/^define( 'DB_HOST', *'[^']*' );/define( 'DB_HOST', '${WORDPRESS_DB_HOST}' );/" /website/wordpress/wp-config.php

	apk add --no-cache php83 php83-phar php83-iconv php-mbstring curl 
	curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar 
	chmod +x wp-cli.phar 
	mv wp-cli.phar /usr/local/bin/wp 
	wp core install --path=/website/wordpress --url=${URL} --title=Inception --admin_user=${WORDPRESS_ADMIN_USERNAME} --admin_password=${WORDPRESS_ADMIN_PASSWORD} --admin_email=${WORDPRESS_ADMIN_EMAIL}
    wp user create --path=/website/wordpress ${WORDPRESS_BASIC_USER_USERNAME} ${WORDPRESS_BASIC_USER_EMAIL} --user_pass=${WORDPRESS_BASIC_USER_PASSWORD}
    apk del php83 php83-phar php83-iconv php-mbstring curl
fi

exec php-fpm83 -F
