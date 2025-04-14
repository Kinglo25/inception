# Makefile for managing Docker containers for the Inception project

# Path to the Docker Compose configuration file
COMPOSE = srcs/docker-compose.yml

# Default target - builds and starts all containers
all: up

# Build and start containers
up:
	# Create data directories if they don't exist
	# These directories will be mounted as volumes in containers
	mkdir -p ~/data/wordpress
	mkdir -p ~/data/mariadb
	
	# Build and start containers in detached mode (-d)
	# --build ensures images are rebuilt if Dockerfiles changed
	docker-compose -f $(COMPOSE) up --build -d
	
	# Display list of running containers
	docker ps

# Remove unused Docker resources
prune:
	# Remove all unused Docker objects (containers, networks, images)
	# -a: all unused images, not just dangling ones
	# -f: force removal without confirmation
	docker system prune -af

# Stop and remove all containers
down:
	# Stop and remove containers and networks
	# -v: remove volumes as well
	docker-compose -f $(COMPOSE) down -v

# Complete cleanup including data volumes
fclean: down
	# Completely remove all data directories
	# Requires sudo to ensure permissions
	sudo rm -rf /home/lomajeru/data
	docker compose -f srcs/docker-compose.yml down --rmi all
	docker builder prune -a


# Rebuild everything from scratch
re: fclean all
	# Full rebuild of the environment:
	# 1. Clean everything (fclean)
	# 2. Build and start (all)

