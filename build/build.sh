#!/bin/bash

ENV=$1

if [ -z "$ENV" ]; then
  echo "Usage: ./build.sh dev|prod"
  exit 1
fi

IMAGE_NAME=kiransuresh12/react-app-$ENV

echo "Building React app..."
npm install
npm run build

echo "Building Docker image: $IMAGE_NAME"
docker build -t $IMAGE_NAME:latest build/

echo "Pushing image to Docker Hub..."
docker push $IMAGE_NAME:latest
