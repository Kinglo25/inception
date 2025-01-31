#!/bin/bash

# Wait for the database to be ready
sleep 10

# Check if wp-config.php already exists
if [ -f /var/www/wordpress/wp-config.php ]; then
    echo "WordPress is already configured."
else
    # Create the wp-config.php file
    wp config create --allow-root \
                     --dbname=$SQL_DATABASE \
                     --dbuser=$SQL_USER \
                     --dbpass=$SQL_PASSWORD \
                     --dbhost=mariadb:3306 --path='/var/www/wordpress'

    # Install WordPress
    wp core install --allow-root \
                    --url=$WORDPRESS_URL \
                    --title=$WORDPRESS_TITLE \
                    --admin_user=$WORDPRESS_ADMIN_USER \
                    --admin_password=$WORDPRESS_ADMIN_PASSWORD \
                    --admin_email=$WORDPRESS_ADMIN_EMAIL \
                    --path='/var/www/wordpress'

    # Create a non-admin user
    wp user create --allow-root \
                   $WORDPRESS_USER $WORDPRESS_USER_EMAIL \
                   --user_pass=$WORDPRESS_USER_PASSWORD \
                   --role=editor \
                   --path='/var/www/wordpress'
fi

# Start PHP-FPM
php-fpm7.4 -F

