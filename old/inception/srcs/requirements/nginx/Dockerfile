FROM debian:bullseye

# Update and upgrade the system, install necessary packages, and clean up
RUN apt update && \
    apt upgrade -y && \
    apt install -y nginx vim curl openssl && \
    rm -rf /var/lib/apt/lists/*

# Create necessary directories and generate SSL certificate
RUN mkdir -p /etc/nginx/ssl /var/run/nginx && \
    openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=lomajeru.42.fr/UID=lomajeru"

# Ensure the /var/www/wordpress directory exists
RUN mkdir -p /var/www/wordpress

# Copy the nginx configuration file
COPY conf/nginx.conf /etc/nginx/nginx.conf

# Set permissions for the web directory
RUN chmod 755 /var/www/wordpress && chown -R www-data:www-data /var/www/wordpress

# Start nginx in the foreground
CMD ["nginx", "-g", "daemon off;"]
