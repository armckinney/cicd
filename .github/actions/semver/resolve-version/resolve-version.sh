#!/usr/bin/env bash
set -euo pipefail

if [[ -n "$VERSION" ]]; then
  BASE="${VERSION#v}"
  echo "Using explicit version: $BASE"

elif [[ "$VERSION_SOURCE" == "git_tag" ]]; then
  BASE="$(git tag --sort=-version:refname \
    | grep -E '^v?[0-9]+\.[0-9]+\.[0-9]+' | head -1 || true)"
  BASE="${BASE#v}"
  echo "Latest git tag: $BASE"

elif [[ "$VERSION_SOURCE" == *"ghcr.io"* ]]; then
  GHCR_PATH="${VERSION_SOURCE#*ghcr.io/}"
  OWNER="$(cut -d'/' -f1 <<< "$GHCR_PATH")"
  IMAGE="$(cut -d'/' -f2 <<< "$GHCR_PATH")"
  echo "Fetching GHCR tags for $OWNER/$IMAGE"

  _fetch_tags() {
    local scope="$1"
    curl -sf \
      -H "Authorization: Bearer $GH_TOKEN" \
      -H "Accept: application/vnd.github+json" \
      "https://api.github.com/${scope}/${OWNER}/packages/container/${IMAGE}/versions?per_page=100" \
      2>/dev/null | jq -r '.[].metadata.container.tags[]' 2>/dev/null || true
  }

  TAGS="$(_fetch_tags orgs)"
  [[ -z "$TAGS" ]] && TAGS="$(_fetch_tags users)"

  BASE="$(grep -E '^v?[0-9]+\.[0-9]+\.[0-9]+$' <<< "$TAGS" \
    | sed 's/^v//' | sort -V | tail -1 || true)"
  echo "Latest GHCR semver tag: $BASE"

elif [[ "$VERSION_SOURCE" == *"github.com"* ]]; then
  if [[ "$VERSION_SOURCE" == *"api.github.com"* ]]; then
    API_URL="${VERSION_SOURCE%%/releases*}/releases/latest"
  else
    REPO_PATH="${VERSION_SOURCE#*github.com/}"
    API_URL="https://api.github.com/repos/${REPO_PATH%/}/releases/latest"
  fi
  echo "Fetching latest GH Release from $API_URL"
  TAG="$(curl -sf \
    -H "Authorization: Bearer $GH_TOKEN" \
    -H "Accept: application/vnd.github+json" \
    "$API_URL" | jq -r '.tag_name')"
  BASE="${TAG#v}"
  echo "Latest GH Release: $BASE"

else
  echo "::error::Unsupported version_source: '$VERSION_SOURCE'"
  echo "  Accepted: git_tag | ghcr.io/<owner>/<image> | https://github.com/<owner>/<repo>"
  exit 1
fi

BASE="${BASE:-0.0.0}"
echo "Resolved base version: $BASE"
echo "version=$BASE" >> "$GITHUB_OUTPUT"
