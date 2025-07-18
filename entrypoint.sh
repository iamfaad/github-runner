#!/bin/bash
set -e

if [ -z "$REPO_URL" ] || [ -z "$RUNNER_TOKEN" ]; then
  echo "REPO_URL and RUNNER_TOKEN must be set"
  exit 1
fi

RUNNER_NAME=${RUNNER_NAME:-$(hostname)}
WORKDIR=${RUNNER_WORKDIR:-/_work}

cd /actions-runner

# Configure the runner
#./config.sh --unattended \
#  --url "$REPO_URL" \
#  --token "$RUNNER_TOKEN" \
#  --name "$RUNNER_NAME" \
#  --work "$WORKDIR" \
#  --replace


# Configure the runner
./config.sh --unattended \
  --url "$REPO_URL" \
  --token "$RUNNER_TOKEN" \
  --name "$NAME" \
  --work "/actions-runner" \
  --replace
  
cleanup() {
  echo "Removing runner..."
  ./config.sh remove --unattended --token "./config.sh --url $REPO_URL --token $RUNNER_TOKEN"
}

trap 'cleanup; exit 130' INT
trap 'cleanup; exit 143' TERM

# Run the runner
./run.sh
