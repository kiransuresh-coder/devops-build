ENV=$1

if [ "$ENV" == "prod" ]; then
  docker-compose -f docker-compose.yml up -d react-app-prod
else
  docker-compose -f docker-compose.yml up -d react-app-dev
fi
