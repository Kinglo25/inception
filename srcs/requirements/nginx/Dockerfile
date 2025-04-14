# Base image: Debian Bullseye (stable version)
FROM debian:bullseye

# Update package lists and install required packages:
# - nginx: Web server
# - netcat & netcat-openbsd: Networking utilities
# - openssl: SSL/TLS toolkit for certificate generation
RUN apt-get update -y && apt-get upgrade -y && apt-get install nginx netcat netcat-openbsd openssl -y

# Create necessary directories:
# - /run/nginx: Required for Nginx runtime
# - /etc/nginx/ssl: Directory for SSL certificates
RUN mkdir -p /run/nginx
RUN mkdir -p /etc/nginx/ssl

# Copy the Nginx configuration from the build context
COPY ./conf/nginx.conf /etc/nginx/conf.d

# Set appropriate permissions for the Nginx configuration and web root
RUN chmod -R 755 /etc/nginx /var/www/html

# Generate a self-signed SSL certificate for HTTPS
# Parameters:
# - Days valid: 365
# - Key size: 2048 bits
# - Subject information: Set to user's details
RUN openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -subj "/C=BE/ST=Bruxelles/L=Bruxelles/0=42/OU=lomajeru/CN=lomajeru.42.fr" \
    -keyout /etc/nginx/ssl/cert.key -out /etc/nginx/ssl/cert.crt

# Expose port 443 for HTTPS connections
EXPOSE 443

# Start Nginx in foreground mode to keep the container running
# "daemon off" ensures Nginx stays in the foreground
CMD ["nginx", "-g", "daemon off;"]
