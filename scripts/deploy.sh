#!/bin/bash
set -e

ENV=$1
REPO_URL=$2
APP_DIR="/app/envflow"

echo "==> Deploying to $ENV environment"

if [ -d "$APP_DIR" ]; then
  echo "==> Pulling latest code"
  cd $APP_DIR && git pull
else
  echo "==> Cloning repo"
  mkdir -p /app && git clone $REPO_URL $APP_DIR
  cd $APP_DIR
fi

echo "==> Starting containers"
cd $APP_DIR
docker compose \
  -f docker-compose.yml \
  -f docker-compose.$ENV.yml \
  --env-file .env.$ENV \
  -p envflow-$ENV \
  up -d --build

echo "==> Deploy complete"
