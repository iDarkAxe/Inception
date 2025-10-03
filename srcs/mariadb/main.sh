#!/bin/ash

set -e

signal_terminate_trap() {
    #
    # Shutdown MariaDB with mariadb-admin
    # https://mariadb.com/kb/en/mariadb-admin/
    mariadb-admin shutdown &
    #
    # Wait for mariadb-admin until sucessfully done (exit)
    wait $!
    echo "MariaDB shut down successfully"
}

trap "signal_terminate_trap" SIGTERM

# Run
if [ "$REQUEST" == "run" ]; then
    echo "Starting MariaDB ..."
    #
    # Run MariaDB with exec bash command
    exec mariadbd &
    #
    # Wait for MariaDB until stopped by Docker
    wait $!
    exit 1
fi

# Initialize
if [ "$REQUEST" == "initialize" ]; then
    initialize_status="MariaDB is already initialized"

    if [ ! -f "$DIR_DATA/ibdata1" ]; then
        initialize_status="MariaDB initialization done"

        # Initialize MariaDB with mariadb-install-db
        # https://mariadb.com/kb/en/mariadb-install-db/
        mariadb-install-db \
            --user=$USER \
            --datadir=$DIR_DATA \
            --auth-root-authentication-method=socket &
        #
        # Wait for mariadb-install-db until sucessfully done (exit)
        wait $!
    fi

    echo $initialize_status
fi
