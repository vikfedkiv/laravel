#!/usr/bin/env bash

# shellcheck disable=SC2005,SC2046,SC1091

set -e

function cancelCurrentPipeline() {
  echo "Active deployment to staging test already running. Pipeline has been canceled..."
  curl -L -X POST \
    -H "Accept: application/vnd.github+json" \
    -H "Authorization: Bearer $CI_GITHUB_API_TOKEN"\
    -H "X-GitHub-Api-Version: 2022-11-28" \
    "https://api.github.com/repos/$CI_GITHUB_REPOSITORY/actions/runs/$CI_PIPELINE_ID/cancel"
  export PIPELINE_CANCELED="true"
}

# Check for running deployment
RUNNING_DEPLOYMENTS="1"
if [ ! "${RUNNING_DEPLOYMENTS}" == "" ]; then
    echo "Deployment already running for Deployment Application - $RUNNING_DEPLOYMENTS"
    cancelCurrentPipeline
  else
    echo "No running deployments. Continue..."
fi
