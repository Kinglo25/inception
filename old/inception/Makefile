# Macros
DOCKER_COMPOSE = docker-compose
DOCKER_COMPOSE_FILE = srcs/docker-compose.yml
DATA_DIR = /home/lomajeru/data
WORDPRESS_DIR = $(DATA_DIR)/wordpress
MARIADB_DIR = $(DATA_DIR)/mariadb

# Targets
.PHONY: all build up down clean prepare

# Default target: prepare directories, build images, and start containers
all: prepare build up

# Prepare target: create necessary directories for volumes
prepare:
    # Create the directory for WordPress files if it doesn't exist
	mkdir -p $(WORDPRESS_DIR)
	sudo chmod 777 $(WORDPRESS_DIR)
    # Create the directory for MariaDB data if it doesn't exist
	mkdir -p $(MARIADB_DIR)
	sudo chmod 777 $(MARIADB_DIR)
	

# Build target: build Docker images
build:
	$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) build

# Up target: start Docker containers in detached mode
up:
	$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) up -d

# Down target: stop Docker containers
down:
	$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) down

# Clean target: stop and remove Docker containers, volumes, and orphan containers
clean: down
	$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) rm -f
	$(DOCKER_COMPOSE) -f $(DOCKER_COMPOSE_FILE) down --volumes --remove-orphans

# Remove cache
prune:
	docker system prune -a
