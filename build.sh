#!/bin/bash
ENV=$1
IMAGE_NAME=kiransuresh12/react-app-$ENV

echo "Building Docker image: $IMAGE_NAME"

docker build -t $IMAGE_NAME:latest .

echo "Pushing image to Docker Hub..."
docker push $IMAGE_NAME:latest
