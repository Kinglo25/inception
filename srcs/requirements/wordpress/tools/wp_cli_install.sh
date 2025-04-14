#!/bin/bash

# This script installs and configures WordPress using WP-CLI
# It's executed when the WordPress container starts

# Wait for MariaDB to be ready before attempting to connect
# This prevents connection errors during container orchestration
sleep 10

# Check if WordPress is already installed by looking for wp-config.php
if [ ! -f "/var/www/html/wp-config.php" ]
then
    echo "Downloading WordPress..."
    # Download the WordPress core files to the specified directory
    wp core download --path="/var/www/html" --allow-root
    
    echo "Creating wp-config.php file..."
    # Create a wp-config.php file with database connection details
    # Variables are populated from environment variables defined in .env
    wp config create --path="/var/www/html" --allow-root --dbname=$MYSQL_DATABASE --dbuser=$MYSQL_USER --dbpass=$MYSQL_PASSWORD --dbhost=$DB_HOST --skip-check
    
    echo "Installing WordPress..."
    # Set up the WordPress site with admin user
    # --skip-email prevents sending installation emails
    wp core install --path="/var/www/html" --allow-root --url=$WP_URL --title=$WP_TITLE --admin_user=$WP_ADMIN --admin_password=$WP_ADMIN_PASS --admin_email=$WP_ADMIN_EMAIL --skip-email
    
    echo "Creating additional user..."
    # Create a regular subscriber user for demonstration
    wp user create "$WP_USER" "$WP_EMAIL" --role=subscriber --user_pass="$WP_PASS" --allow-root --path=/var/www/html
    
else
    echo "WordPress is already installed."
fi

# Start PHP-FPM in foreground mode
# The -F flag keeps the process in the foreground, required for Docker
exec /usr/sbin/php-fpm7.4 -F

