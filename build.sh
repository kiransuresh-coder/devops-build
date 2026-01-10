ENV=$1

if [ "$ENV" == "prod" ]; then
  IMAGE="kiransuresh12/react-app-prod"
else
  IMAGE="kiransuresh12/react-app-dev"
fi

docker build -t $IMAGE:latest .
docker push $IMAGE:latest
