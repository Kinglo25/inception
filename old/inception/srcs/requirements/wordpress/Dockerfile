FROM debian:bullseye

# Update, upgrade, install necessary packages, and clean up
RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y php7.4 php7.4-fpm php7.4-mysql mariadb-client wget && \
    rm -rf /var/lib/apt/lists/*

# Download and extract WordPress
RUN wget https://fr.wordpress.org/wordpress-6.0-fr_FR.tar.gz -P /var/www && \
    cd /var/www && \
    tar -xzf wordpress-6.0-fr_FR.tar.gz && \
    rm wordpress-6.0-fr_FR.tar.gz && \
    chown -R root:root /var/www/wordpress
	
# Create the /run/php directory
RUN mkdir -p /run/php && chown -R www-data:www-data /run/php

# Copy PHP-FPM configuration file
COPY /conf/www.conf /etc/php/7.4/fpm/pool.d/

# Download and install WP-CLI
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

# Copy the auto configuration script and make it executable
COPY /conf/auto_config.sh /usr/local/bin
RUN chmod +x /usr/local/bin/auto_config.sh

# Set the entrypoint to the auto configuration script
ENTRYPOINT ["/usr/local/bin/auto_config.sh"]
