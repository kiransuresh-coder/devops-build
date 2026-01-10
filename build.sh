#!/bin/bash

ENV=$1

if [ "$ENV" == "prod" ]; then
  IMAGE="kiransuresh12/react-app-prod"
else
  IMAGE="kiransuresh12/react-app-dev"
fi

echo "Building Docker image: $IMAGE"

docker build -t $IMAGE:latest .
docker push $IMAGE:latest
