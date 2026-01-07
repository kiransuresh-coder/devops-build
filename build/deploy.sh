#!/bin/bash

ENV=$1   # dev or prod

if [ -z "$ENV" ]; then
  echo "Usage: ./deploy.sh dev|prod"
  exit 1
fi

export ENVIRONMENT=$ENV

echo "Deploying environment: $ENV"

docker-compose down
docker-compose pull
docker-compose up -d

echo "Deployment completed for $ENV"
docker ps -f name=my-react-$ENV
