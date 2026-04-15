#!/bin/bash
docker compose \
  -f docker-compose.yml \
  -f docker-compose.staging.yml \
  --env-file .env.staging \
  "$@"
