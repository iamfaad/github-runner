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
  --url "https://github.com/iamfaad/odoo-18" \
  --token "AJG6HYHXBMB4QZ6O4MG6KMLIM4R7M" \
  --name "image-builder" \
  --work "/" \
  --replace
cleanup() {
  echo "Removing runner..."
  ./config.sh remove --unattended --token "AJG6HYHXBMB4QZ6O4MG6KMLIM4R7M"
}

trap 'cleanup; exit 130' INT
trap 'cleanup; exit 143' TERM

# Run the runner
./run.sh
