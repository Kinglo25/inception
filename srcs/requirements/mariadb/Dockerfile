# Base image: Debian Bullseye (stable version)
FROM debian:bullseye

# Update package lists and install MariaDB server
# MariaDB is a MySQL-compatible database server
RUN apt-get update -y && apt-get upgrade -y && apt-get install mariadb-server -y

# Copy MariaDB server configuration file
# This configures network settings and other database parameters
COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

# Copy the database initialization script 
COPY ./tools/db_init.sh /usr/local/bin/db_init.sh 

# Make the initialization script executable
RUN chmod 755 /usr/local/bin/db_init.sh

# Expose port 3306 for database connections
EXPOSE 3306

# Run the database initialization script when the container starts
CMD ["/usr/local/bin/db_init.sh"]
