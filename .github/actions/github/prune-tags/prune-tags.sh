#!/usr/bin/env bash
set -euo pipefail

if [[ -z "${PRERELEASE_PREFIX}" ]]; then
  echo "Error: PRERELEASE_PREFIX is empty"
  exit 1
fi

echo "Pruning dev tags and GitHub Releases matching ${PRERELEASE_PREFIX}.* ..."

# Configure git identity if not already set
git config user.email || git config user.email "actions@github.com"
git config user.name  || git config user.name  "GitHub Actions"

# Safely fetch and delete matching remote/local dev tags and GitHub Releases
git tag -l "${PRERELEASE_PREFIX}.*" | while read -r tag; do
  if [[ -n "$tag" ]]; then
    echo "Pruning dev tag and release: $tag"
    gh release delete "$tag" --yes --cleanup-tag || true
    git tag -d "$tag" || true
    git push --delete origin "$tag" || true
  fi
done
