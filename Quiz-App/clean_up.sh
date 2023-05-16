#!/bin/bash

# Stop all running containers
echo "Stopping all running containers..."
if [ "$(docker ps -q)" ]; then
    docker stop $(docker ps -aq)
else
    echo "No running containers found."
fi

# Remove all containers
echo "Removing all containers..."
if [ "$(docker ps -aq)" ]; then
    docker rm $(docker ps -aq)
else
    echo "No containers found."
fi

# Remove all unused images
echo "Removing unused images..."
docker image prune -a --force

# Perform a system prune to free up disk space
echo "Performing system prune..."
docker system prune -a --force

echo "Cleanup complete!"
