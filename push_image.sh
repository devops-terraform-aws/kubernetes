#!/bin/bash

# Prompt the user for Docker Hub username
read -p "Enter your Docker Hub username: " DOCKERHUB_USERNAME
IMAGE_NAME="create-ec2"

# Build the Docker image
docker build -t $DOCKERHUB_USERNAME/$IMAGE_NAME .

# Authenticate with Docker Hub using the provided username
if docker login --username $DOCKERHUB_USERNAME; then
  # Tag the Docker image with the Docker Hub username and image name
  docker tag $DOCKERHUB_USERNAME/$IMAGE_NAME $DOCKERHUB_USERNAME/$IMAGE_NAME

  # Push the Docker image to Docker Hub
  docker push $DOCKERHUB_USERNAME/$IMAGE_NAME

  # Logout from Docker Hub
  docker logout
else
  echo "Invalid Docker Hub username or password. Please try again."
fi

