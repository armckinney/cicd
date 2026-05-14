#!/usr/bin/env bash
set -euo pipefail

if [[ "$GITHUB_REF_NAME" == "$DEFAULT_BRANCH" ]]; then
  echo "Looking up merged PR for commit $GITHUB_SHA"
  PR_JSON="$(gh api "repos/${REPO}/commits/${GITHUB_SHA}/pulls" \
    --jq '.[0] // empty' 2>/dev/null || true)"
else
  echo "Looking up open PR for branch $GITHUB_REF_NAME"
  PR_JSON="$(gh api "repos/${REPO}/pulls" \
    --field state=open \
    --field head="${REPO_OWNER}:${GITHUB_REF_NAME}" \
    --jq '.[0] // empty' 2>/dev/null || true)"
fi

if [[ -z "$PR_JSON" || "$PR_JSON" == "null" ]]; then
  echo "No PR found; defaulting to patch bump"
  echo "pr_number=" >> "$GITHUB_OUTPUT"
  echo "bump_type=patch" >> "$GITHUB_OUTPUT"
  echo "json=" >> "$GITHUB_OUTPUT"
  exit 0
fi

PR_NUMBER="$(jq -r '.number' <<< "$PR_JSON")"
BUMP_TYPE="$(jq -r '[(.labels // [])[] | .name] | map(select(startswith("bump:"))) | .[0] // "bump:patch"' \
  <<< "$PR_JSON" | sed 's/bump://')"
JSON_COMPACT="$(jq -c '.' <<< "$PR_JSON")"

echo "PR #${PR_NUMBER} — bump: ${BUMP_TYPE}"
echo "pr_number=${PR_NUMBER}" >> "$GITHUB_OUTPUT"
echo "bump_type=${BUMP_TYPE}" >> "$GITHUB_OUTPUT"
echo "json=${JSON_COMPACT//'%'/'%25'}" >> "$GITHUB_OUTPUT"
