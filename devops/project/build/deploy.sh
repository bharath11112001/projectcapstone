#!/bin/bash
git_branch=$(git rev-parse --abbrev-ref HEAD)
if [[ $git_branch == "main" ]]; then
  ./build.sh
  docker tag mynginximg bharath883/prod:latest
  docker push $bharath883/prod:latest
elif [[ $git_branch == "dev" ]]; then
  ./build.sh
  docker tag mynginximg bharath883/dev:latest
  docker push bharath883/dev:latest
else
  echo "Deployment failed: Unsupported branch '$git_branch'"
  exit 1
fi
