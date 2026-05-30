#!/usr/bin/env bash
set -euo pipefail

# Parse version attributes using Verge CLI
is_prerelease=$(verge parse "$VERSION" --field is_prerelease --format text)

push_floating="$PUSH_FLOATING_TAGS"

exact_tag="${VERSION}"
tags=("$exact_tag")

# Configure git identity if not already set
git config user.email || git config user.email "actions@github.com"
git config user.name  || git config user.name  "GitHub Actions"

git tag -f "$exact_tag"

if [[ "$push_floating" != "false" ]] && [[ "$is_prerelease" != "true" ]]; then
  # Retrieve formatted floating tags directly from Verge CLI
  floating_major=$(verge parse "$VERSION" --field floating.major --format text)
  floating_minor=$(verge parse "$VERSION" --field floating.minor --format text)

  floating_tags=(
    "$floating_major"
    "$floating_minor"
    "latest"
  )

  for tag in "${floating_tags[@]}"; do
    git tag -f "$tag"
    tags+=("$tag")
  done
fi

git push origin "${tags[@]/#/}" --force

echo "tags=${tags[*]}" >> "$GITHUB_OUTPUT"


