#!/usr/bin/env bash
set -euo pipefail

# Strip leading 'v' if present
version="${VERSION#v}"

# Any characters beyond X.Y.Z indicate a prerelease
is_prerelease=false
[[ "$version" =~ ^[0-9]+\.[0-9]+\.[0-9]+(.+)?$ ]] && [[ -n "${BASH_REMATCH[1]}" ]] && is_prerelease=true

IFS='.' read -r major minor patch_full <<< "$version"
patch="${patch_full%%[^0-9]*}"  # strip anything after the numeric patch

push_floating="$PUSH_FLOATING_TAGS"

exact_tag="v${version}"
tags=("$exact_tag")

if $is_prerelease; then
  # Expected prerelease format: X.Y.Zpr<pr_number><label><labelid>
  if [[ "$version" =~ ^[0-9]+\.[0-9]+\.[0-9]+pr([0-9]+).*$ ]]; then
    pr_number="${BASH_REMATCH[1]}"
    echo "Prerelease tag detected for PR #${pr_number}; cleaning remote PR tags before push"

    mapfile -t remote_pr_tags < <(
      git ls-remote --tags origin \
        | awk '{print $2}' \
        | sed 's#refs/tags/##' \
        | sed 's/\^{}//' \
        | sort -u \
        | grep -E "^v[0-9]+\.[0-9]+\.[0-9]+pr${pr_number}.*$" || true
    )

    for old_tag in "${remote_pr_tags[@]}"; do
      echo "Deleting remote PR tag: $old_tag"
      git push origin ":refs/tags/$old_tag"
    done
  else
    echo "::warning::Prerelease version '$version' did not match expected PR format; skipping PR tag cleanup"
  fi
fi

# Configure git identity if not already set
git config user.email || git config user.email "actions@github.com"
git config user.name  || git config user.name  "GitHub Actions"

git tag -f "$exact_tag"

if [[ "$push_floating" != "false" ]] && ! $is_prerelease; then
  floating_tags=(
    "v${major}"
    "v${major}.${minor}"
    "latest"
  )

  for tag in "${floating_tags[@]}"; do
    git tag -f "$tag"
    tags+=("$tag")
  done
fi

git push origin "${tags[@]/#/}" --force

echo "tags=${tags[*]}" >> "$GITHUB_OUTPUT"
