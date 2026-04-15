#!/bin/bash
set -e

# Arguments passed from pipeline
ENV=$1          # "staging" or "prod"
REPO_URL=$2     # https://github.com/sarath-test-1/envflow.git
ENV_CONTENT=$3  # contents of the .env file

APP_DIR="/app/envflow"

echo "==> Deploying to $ENV environment"

# Clone repo if first deploy, pull if exists
if [ -d "$APP_DIR" ]; then
  echo "==> Pulling latest code"
  cd $APP_DIR && git pull
else
  echo "==> Cloning repo"
  mkdir -p /app && git clone $REPO_URL $APP_DIR
  cd $APP_DIR
fi

# Write env file from secret — never stored in git
echo "==> Writing environment config"
echo "$ENV_CONTENT" > .env.$ENV

# Run compose with correct overlay
echo "==> Starting containers"
docker compose \
  -f docker-compose.yml \
  -f docker-compose.$ENV.yml \
  --env-file .env.$ENV \
  -p envflow-$ENV \
  up -d --build

echo "==> Deploy complete"
