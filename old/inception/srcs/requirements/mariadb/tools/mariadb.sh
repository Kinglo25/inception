#!/bin/bash

# Exit on error
set -e

echo "Initializing MariaDB data directory..."

# Initialize MariaDB data directory if needed
if [ ! -d "/var/lib/mysql/mysql" ]; then
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql
fi

echo "Starting MariaDB with skip-grant-tables and skip-networking..."
# Start MariaDB with skip-grant-tables to allow password changes
mysqld_safe --skip-grant-tables --skip-networking &

# Function to check if MariaDB is ready
is_mariadb_ready() {
    mysqladmin ping -h127.0.0.1 --silent
}

# Wait until MariaDB is ready or timeout after 30 seconds
TIMEOUT=30
while ! is_mariadb_ready; do
    if [ $TIMEOUT -le 0 ]; then
        echo "Fatal error"
        exit 1
    fi
    sleep 1
    TIMEOUT=$((TIMEOUT - 1))
done

echo "Setting root password and creating user/database..."
# Initial setup without password
mysql -u root << EOF
FLUSH PRIVILEGES;
ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';
CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;
CREATE USER IF NOT EXISTS '${SQL_USER}'@'%' IDENTIFIED BY '${SQL_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO '${SQL_USER}'@'%';
FLUSH PRIVILEGES;
EOF

echo "Shutting down MariaDB to apply changes..."
# Shutdown MariaDB after setup
mysqladmin shutdown --user=root --password="${SQL_ROOT_PASSWORD}"

sleep 5

echo "Starting MariaDB normally..."
# Start MariaDB normally
chown -R mysql:mysql /var/lib/mysql
chmod -R 755 /var/lib/mysql
exec mysqld
