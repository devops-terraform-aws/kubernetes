#!/bin/bash

# Stop all running containers
echo "Stopping all running containers..."
docker stop $(docker ps -aq)

# Remove all containers
echo "Removing all containers..."
docker rm $(docker ps -aq)

# Remove all unused images
echo "Removing unused images..."
docker image prune -a --force

# Perform a system prune to free up disk space
echo "Performing system prune..."
docker system prune -a --force

echo "Cleanup complete!"