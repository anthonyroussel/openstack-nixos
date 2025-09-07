#!/usr/bin/env bash
set -euo pipefail

PACKAGES=$(nix flake show --json | jq -r '[.packages[] | keys[]] | sort | unique | join(",")')

for PACKAGE in ${PACKAGES//,/ }; do
  echo "Updating package '${PACKAGE}'."
  nix-update --flake --commit "${PACKAGE}"
done
