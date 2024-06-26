#!/bin/bash

# Ensure a branch name is provided as an argument
if [ $# -eq 0 ]; then
    echo "Error: No branch name provided."
    exit 1
fi

# Assign the first argument (branch name) to a variable
branch="$1"

# Validate the branch name
if [ "$branch" == "main" ]; then
    echo "Deploying for main branch..."
    # Perform deployment steps for main branch
    # Example: Replace with your actual deployment commands for 'main'
    docker-compose down
    docker-compose -f docker-compose.yml up -d --build
elif [ "$branch" == "Dev" ]; then
    echo "Deploying for Dev branch..."
    # Perform deployment steps for Dev branch
    # Example: Replace with your actual deployment commands for 'Dev'
    docker-compose down
    docker-compose -f docker-compose.yml up -d --build
else
    echo "Deployment failed: Unsupported branch '$branch'"
    exit 1
fi

echo "Deployment successful for branch '$branch'"
