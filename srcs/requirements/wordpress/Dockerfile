# Base image: Debian Bullseye (stable version)
FROM debian:bullseye

# Update package lists and install required packages with specific PHP version
RUN apt-get update -y && apt-get upgrade -y && \
    apt-get install -y \
    php7.4 \
    php7.4-fpm \
    php7.4-mysql \
    curl

# Download and install WP-CLI (WordPress Command Line Interface)
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

# Copy PHP-FPM configuration from the build context
COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/

# Create the PHP-FPM run directory for socket files
RUN mkdir -p /run/php

# Set the working directory for the container
WORKDIR	/var/www/wordpress

# Copy the WordPress setup script to the container
COPY ./tools/wp_cli_install.sh /usr/local/bin/wp_cli_install.sh

# Make the setup script executable
RUN chmod +x /usr/local/bin/wp_cli_install.sh 

# Expose port 9000 for PHP-FPM to listen on
EXPOSE 9000

# Define the command to run when the container starts
ENTRYPOINT ["/usr/local/bin/wp_cli_install.sh"]



