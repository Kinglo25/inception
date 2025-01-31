FROM debian:bullseye

# Update, upgrade, install necessary packages, and clean up
RUN apt-get update -y && \
    apt-get upgrade -y && \
    apt-get install -y mariadb-server net-tools && \
    rm -rf /var/lib/apt/lists/*

# Copy the MariaDB configuration file
COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

# Copy the MariaDB initialization script
COPY tools/mariadb.sh /usr/local/bin/

# Make the initialization script executable
RUN chmod +x /usr/local/bin/mariadb.sh

# Set the entrypoint to the initialization script
ENTRYPOINT ["/bin/bash", "/usr/local/bin/mariadb.sh"]
