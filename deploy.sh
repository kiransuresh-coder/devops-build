#!/bin/bash
ENV=$1

APP_NAME="react-app-$ENV"

echo "Starting deployment for environment: $ENV"

docker rm -f $APP_NAME || true

docker-compose up -d
