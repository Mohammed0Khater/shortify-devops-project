#!/bin/bash
echo "--- Starting Deployment ---"
# Log in to GHCR. GITHUB_TOKEN and GITHUB_ACTOR are auto-provided.
echo $GITHUB_TOKEN | docker login ghcr.io -u $GITHUB_ACTOR --password-stdin
# Run the production compose file
docker-compose -f docker-compose.prod.yml up -d
echo "--- Deployment Complete! ---"
