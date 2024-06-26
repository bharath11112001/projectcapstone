
#!/bin/bash
git_branch=$(git rev-parse --abbrev-ref HEAD)

if [[ $git_branch == "main" ]]; then
  echo "Deploying for main branch"
  # Add your deployment steps for main branch here
elif [[ $git_branch == "Dev" ]]; then
  echo "Deploying for Dev branch"
  # Add your deployment steps for Dev branch here
else
  echo "Deployment failed: Unsupported branch '$git_branch'"
  exit 1
fi
