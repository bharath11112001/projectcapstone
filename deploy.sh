#!/bin/bash

BRANCH_NAME=$1

if [[ "$BRANCH_NAME" == "main" ]]; then
  ./build.sh
  docker tag mynginximg bharath883/prod:latest
  docker push bharath883/prod:latest
elif [[ "$BRANCH_NAME" == "Dev" ]]; then
  ./build.sh
  docker tag mynginximg bharath883/dev:latest
  docker push bharath883/dev:latest
else
  echo "Deployment failed: Unsupported branch '$BRANCH_NAME'"
  exit 1
fi
