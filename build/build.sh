#!/bin/bash
set -e

ENV=$1
if [ -z "$ENV" ]; then
  echo "Usage: ./build.sh dev|prod"
  exit 1
fi

IMAGE="kiransuresh/react-app:${ENV}"

docker build -t $IMAGE -f build/Dockerfile .
