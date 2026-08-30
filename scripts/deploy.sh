#!/bin/bash

set -e

IMAGE_NAME="finsight-backend"
CONTAINER_NAME="finsight-backend"

echo "Stopping existing container..."
docker stop "$CONTAINER_NAME" 2>/dev/null || true
docker rm "$CONTAINER_NAME" 2>/dev/null || true

echo "Building Docker image..."
docker build -t "$IMAGE_NAME:latest" .

echo "Starting backend..."

docker run -d \
  --name "$CONTAINER_NAME" \
  --restart unless-stopped \
  -p 8080:8080 \
  -e DB_URL="$DB_URL" \
  -e DB_USERNAME="$DB_USERNAME" \
  -e DB_PASSWORD="$DB_PASSWORD" \
  -e JWT_SECRET="$JWT_SECRET" \
  "$IMAGE_NAME:latest"

echo "Backend container started."

docker ps --filter "name=$CONTAINER_NAME"