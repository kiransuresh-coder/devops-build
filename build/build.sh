#!/bin/bash

ENV=$1

if [ -z "$ENV" ]; then
  echo "Usage: ./build.sh dev|prod"
  exit 1
fi

echo "====================================="
echo " Building React Docker Image"
echo " Environment: $ENV"
echo "====================================="

docker build -t react-app:latest .

if [ $? -ne 0 ]; then
  echo "❌ Docker build failed"
  exit 1
fi

echo "✅ Docker image built successfully"
