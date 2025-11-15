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
: "${WP_INSTALL_PATH:?WP_INSTALL_PATH not set}"

if ! wp core is-installed --path=${WP_INSTALL_PATH} --url="${URL}"; then
    rm ${WP_INSTALL_PATH}/wp-config.php
    wp config create \
        --dbname="${WORDPRESS_DB_NAME}" \
        --dbuser="${WORDPRESS_DB_USER}" \
        --dbpass="${WORDPRESS_DB_PASSWORD}" \
        --dbhost="${WORDPRESS_DB_HOST}" \
        --path=${WP_INSTALL_PATH} \
        --url="${URL}"

    wp core install \
        --path=${WP_INSTALL_PATH} \
        --url="${URL}" \
        --title=Inception \
        --admin_user="${WORDPRESS_ADMIN_USERNAME}" \
        --admin_password="${WORDPRESS_ADMIN_PASSWORD}" \
        --admin_email="${WORDPRESS_ADMIN_EMAIL}"

    wp user create \
        "${WORDPRESS_BASIC_USER_USERNAME}" "${WORDPRESS_BASIC_USER_EMAIL}" \
        --user_pass="${WORDPRESS_BASIC_USER_PASSWORD}" \
        --path=${WP_INSTALL_PATH}
    # rm /usr/local/bin/wp
fi

exec php-fpm83 -F
