#!/bin/bash
ENV=$1

echo "Starting deployment for environment: $ENV"

# Stop & remove any old container (dev or prod)
if docker ps -q -f name=react-app-dev; then
  echo "Stopping my-react-dev..."
  docker stop react-app-dev
  docker rm react-app-dev
fi

if docker ps -q -f name=my-react-prod; then
  echo "Stopping react-app-prod..."
  docker stop react-app-prod
  docker rm react-app-prod
fi

# Run new container with docker-compose
echo "Launching react-app-$ENV..."
ENVIRONMENT=$ENV docker-compose up -d --build

# Verify container is running
docker ps -f name=react-app-$ENV
