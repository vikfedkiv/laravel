#!/bin/bash

GITHUB_TOKEN=$GH_TOKEN

# Usage: hub-pr-merge <PR-NUMBER>

# If a script errors, force the script to fail immediately.
set -e

ID=$1
shift 1

# https://developer.github.com/v3/pulls/#merge-a-pull-request-merge-button
curl -XPUT -H "Authorization: token $GITHUB_TOKEN" "https://api.github.com/repos/$TRAVIS_REPO_SLUG/pulls/$ID/merge"
