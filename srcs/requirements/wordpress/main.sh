#!/bin/ash

set -e

# Si wp-config.php n’existe pas encore, le créer
if [ ! -f /website/wordpress/wp-config.php ]; then
    cp /website/wordpress/wp-config-sample.php /website/wordpress/wp-config.php

    sed -i "s/^define( 'DB_NAME', *'[^']*' );/define( 'DB_NAME', '${WORDPRESS_DB_NAME}' );/" /website/wordpress/wp-config.php
    sed -i "s/^define( 'DB_USER', *'[^']*' );/define( 'DB_USER', '${WORDPRESS_DB_USER}' );/" /website/wordpress/wp-config.php
    sed -i "s/^define( 'DB_PASSWORD', *'[^']*' );/define( 'DB_PASSWORD', '${WORDPRESS_DB_PASSWORD}' );/" /website/wordpress/wp-config.php
    sed -i "s/^define( 'DB_HOST', *'[^']*' );/define( 'DB_HOST', '${WORDPRESS_DB_HOST}' );/" /website/wordpress/wp-config.php
fi

exec php-fpm83 -F
