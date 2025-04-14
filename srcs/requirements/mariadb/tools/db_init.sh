#!/bin/bash

# This script initializes the MariaDB database for WordPress
# It runs when the MariaDB container starts for the first time

# Start MariaDB in safe mode in the background
# This is needed to configure the database before regular operation
mysqld_safe &

# Wait for MariaDB to finish initialization
# This prevents trying to run commands before the server is ready
sleep 3

# Run SQL commands to configure the database
# These commands:
# 1. Create the WordPress database
# 2. Create a database user for WordPress
# 3. Grant permissions to the user
# 4. Set the root password
# 5. Apply all changes
mysql -u root <<EOF
CREATE DATABASE IF NOT EXISTS \`$MYSQL_DATABASE\`;
CREATE USER IF NOT EXISTS \`$MYSQL_USER\`@'%' IDENTIFIED BY '$MYSQL_PASSWORD';
GRANT ALL PRIVILEGES ON \`$MYSQL_DATABASE\`.* TO \`$MYSQL_USER\`@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';
FLUSH PRIVILEGES;
EOF

# Shut down the temporary MariaDB instance
# This ensures a clean state before the main process starts
mysqladmin -u root -p"$MYSQL_ROOT_PASSWORD" shutdown

# Start MariaDB in safe mode as the main process
# Using exec replaces the current process, ensuring proper signal handling
exec mysqld_safe
