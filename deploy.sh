#!/bin/bash

echo "--- Starting Deployment ---"

# Check if GITHUB_TOKEN is set
if [ -z "$GITHUB_TOKEN" ]; then
  echo "Error: GITHUB_TOKEN is not set. Cannot log in to GHCR."
  exit 1
fi

# Log in to the GitHub Container Registry non-interactively
# The GITHUB_TOKEN is automatically available in Codespaces
echo "$GITHUB_TOKEN" | docker login ghcr.io -u "$GITHUB_ACTOR" --password-stdin

# Run the production docker-compose file
docker-compose -f docker-compose.prod.yml up -d

echo "--- Deployment Complete! ---"
echo "Application should be available at the forwarded port 80."
echo "Grafana is at port 3000. Prometheus is at port 9090."
