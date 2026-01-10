#!/bin/bash

ENV=$1

if [ "$ENV" == "prod" ]; then
  SERVICE="react-app-prod"
else
  SERVICE="react-app-dev"
fi

echo "Starting deployment for environment: $ENV"

docker rm -f react-app-dev || true
docker rm -f react-app-prod || true

docker-compose up -d $SERVICE
