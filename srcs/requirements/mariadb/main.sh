#!/bin/ash

# -e = exit on error, -u = undefined var = error
set -eu

# Check that VARS are not empty and write a message if empty
: "${MYSQL_DATABASE:?MYSQL_DATABASE not set}"
: "${MYSQL_USER:?MYSQL_USER not set}"
: "${WORDPRESS_DB_PASSWORD:?WORDPRESS_DB_PASSWORD not set}"

signal_terminate_trap() {
    # Shutdown MariaDB with mariadb-admin
    # https://mariadb.com/kb/en/mariadb-admin/
    mariadb-admin shutdown &
    # Wait for mariadb-admin until sucessfully done (exit)
    wait $!
    echo "MariaDB shut down successfully"
}

trap "signal_terminate_trap" SIGTERM

if [ ! -d "/var/lib/mysql/mysql" ]; then
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql --basedir=/usr
fi
/usr/bin/mariadbd-safe --datadir='/var/lib/mysql' &
PID=$!

# Wait for MariaDB to be ready
echo "Waiting for MariaDB to be ready..."
until mariadb -e "SELECT 1" >/dev/null 2>&1; do
    sleep 1
done
echo "MariaDB is ready!"

echo "Initializing database..."
if ! mariadb -e "SHOW DATABASES;" | grep -q "$MYSQL_DATABASE"; then
    echo "Table Users not found, creating..."
    mariadb << EOF
    CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;
    USE $MYSQL_DATABASE;
    CREATE TABLE Users (
        userid INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
        username VARCHAR(255) NOT NULL,
        role VARCHAR(255) NOT NULL
    );
    INSERT INTO Users (username, role)
        VALUES ("$MYSQL_USER", "admin");
    INSERT INTO Users (username, role) 
        VALUES("tester", "user");
EOF

# Secure the database, as mariadb-secure-installation is ONLY interactive, doing the secure manually
echo "Securing!"
mariadb << EOF
-- Supprimer les utilisateurs anonymes
DELETE FROM mysql.user WHERE User='';

-- Supprimer la base de test
DROP DATABASE IF EXISTS test;

GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$WORDPRESS_DB_HOST' IDENTIFIED BY '$WORDPRESS_DB_PASSWORD';

-- Recharger les privilèges
FLUSH PRIVILEGES;
EOF
echo "Database secured!"

else
    echo "Database already exists and is secure, skipping creation."
fi

echo "Database initialized successfully!"

# Stop temporary MariaDB
mariadb-admin shutdown
wait $PID || true

# Relaunch MariaDB in foreground (PID 1)
echo "Starting MariaDB in foreground..."
exec /usr/bin/mariadbd-safe --datadir='/var/lib/mysql'
