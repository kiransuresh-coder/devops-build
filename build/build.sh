#!/bin/bash

ENV=$1   # dev or prod

if [ -z "$ENV" ]; then
  echo "Usage: ./build.sh dev|prod"
  exit 1
fi

IMAGE_NAME=kiran/react-app-$ENV

echo "Building React app..."
npm install
npm run build

echo "Building Docker image: $IMAGE_NAME"
docker build -t $IMAGE_NAME:latest .

echo "Pushing image to Docker Hub..."
docker push $IMAGE_NAME:latest

echo "Docker image $IMAGE_NAME pushed successfully"
