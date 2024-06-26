#!/bin/bash
git_branch=$(git rev-parse --abbrev-ref main)
echo "Current branch: $git_branch"

if [[ $git_branch == "main" ]]; then
  echo "Building and deploying for main branch..."
  ./build.sh
  docker tag mynginximg bharath883/prod:latest
  docker push bharath883/prod:latest
elif [[ $git_branch == "dev" ]]; then
  echo "Building and deploying for dev branch..."
  ./build.sh
  docker tag mynginximg bharath883/dev:latest
  docker push bharath883/dev:latest
else
  echo "Deployment failed: Unsupported branch '$git_branch'"
  exit 1
fi
