#!/bin/bash
BRANCH_NAME=$1

echo "Current Git Branch: ${BRANCH_NAME}"
docker-compose down
docker system prune -f && docker volume prune -f && docker network prune -f
echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
if [[ "${BRANCH_NAME}" == "origin/Prod" ]]; then
     ./build.sh 
     docker tag mynginximg bharath883/prod:latest
     docker push bharath883/prod:latest
elif [[ "${BRANCH_NAME}" == "origin/Dev" ]]; then
      
       ./build.sh
        docker tag mynginximg bharath883/dev:latest
        docker push bharath883/dev:latest
else
    echo "Deployment Failed ${BRANCH_NAME}"
    exit 1
fi
docker-compose up -d
