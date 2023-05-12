#!/bin/bash

# Set the Docker Hub username and image name
DOCKERHUB_USERNAME="your_username"
IMAGE_NAME="my-python-app"

# Build the Docker image
docker build -t $DOCKERHUB_USERNAME/$IMAGE_NAME .

# Authenticate with Docker Hub
docker login

# Tag the Docker image with the Docker Hub username and image name
docker tag $DOCKERHUB_USERNAME/$IMAGE_NAME $DOCKERHUB_USERNAME/$IMAGE_NAME

# Push the Docker image to Docker Hub
docker push $DOCKERHUB_USERNAME/$IMAGE_NAME

# Logout from Docker Hub
docker logout
