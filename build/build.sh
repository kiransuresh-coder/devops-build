#!/bin/bash

ENV=$1

if [ -z "$ENV" ]; then
  echo "Usage: ./build.sh dev|prod"
  exit 1
fi

echo "Building React Docker Image for $ENV"

docker build -t react-app:latest .
