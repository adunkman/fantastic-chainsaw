#!/usr/bin/env bash

set -ex

echo "Setup Cloud Foundry CLI"

curl -v -L -o cf-cli_amd64.deb "https://cli.run.pivotal.io/stable?release=debian64&source=github"
sudo dpkg -i cf-cli_amd64.deb
cf -v
cf api https://api.fr.cloud.gov
cf auth "$CF_USERNAME" "$CF_PASSWORD"
cf target -o "$CF_ORG" -s "$CF_SPACE"

echo "Setup Autopilot Cloud Foundry CLI plugin"

curl -v -L -o autopilot-linux "https://github.com/contraband/autopilot/releases/download/0.0.8/autopilot-linux"
cf install-plugin -f autopilot-linux

echo "Perform zero-downtime deployment (zero-downtime-push)"

cf zero-downtime-push "$CF_APP" -f manifest.yml
