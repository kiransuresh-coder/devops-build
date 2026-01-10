#!/bin/bash
ENV=$1

IMAGE_NAME="kiransuresh12/react-app-$ENV"

echo "Building Docker image: $IMAGE_NAME"

docker build -t $IMAGE_NAME .
docker push $IMAGE_NAME
