#!/bin/bash
IMAGE_NAME=$1
DOCKER_HUB_USERNAME=$2
DOCKER_HUB_PASSWORD=$3
BUILD_NUMBER=$4

if [ -z "$IMAGE_NAME" ] || [ -z "$DOCKER_HUB_USERNAME" ] || [ -z "$DOCKER_HUB_PASSWORD" ] || [ -z "$BUILD_NUMBER" ]; then
  echo "Usage: ./deploy.sh <image-name> <docker-hub-username> <docker-hub-password> <build-number>"
  exit 1
fi

docker tag mynginximg ${IMAGE_NAME}:${BUILD_NUMBER}
echo $DOCKER_HUB_PASSWORD | docker login -u $DOCKER_HUB_USERNAME --password-stdin
docker push ${IMAGE_NAME}:${BUILD_NUMBER}
