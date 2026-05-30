#!/usr/bin/env bash
set -euo pipefail

PR_JSON=""

echo "Looking up PR associated with commit $GITHUB_SHA"
PR_JSON="$(gh api "repos/${REPO}/commits/${GITHUB_SHA}/pulls" \
  --jq '[.[] | select(.state == "open")][0] // .[0] // empty' 2>/dev/null || true)"

if [[ -z "$PR_JSON" || "$PR_JSON" == "null" ]]; then
  echo "No PR found by commit; looking up open PR by branch owner/ref"
  PR_JSON="$(gh api "repos/${REPO}/pulls" \
    --field state=open \
    --field head="${REPO_OWNER}:${GITHUB_REF_NAME}" \
    --jq '.[0] // empty' 2>/dev/null || true)"
fi

if [[ -z "$PR_JSON" || "$PR_JSON" == "null" ]]; then
  echo "No PR found by owner/ref; scanning open PRs by head ref"
  PR_JSON="$(gh api "repos/${REPO}/pulls" \
    --field state=open \
    --field per_page=100 \
    --jq '[.[] | select(.head.ref == env.GITHUB_REF_NAME)][0] // empty' 2>/dev/null || true)"
fi

if [[ -z "$PR_JSON" || "$PR_JSON" == "null" ]]; then
  echo "No PR found; defaulting to major bump"
  echo "Context: repo=${REPO} ref=${GITHUB_REF_NAME} sha=${GITHUB_SHA}"
  echo "pr_number=" >> "$GITHUB_OUTPUT"
  echo "bump_type=major" >> "$GITHUB_OUTPUT"
  echo "json=" >> "$GITHUB_OUTPUT"
  exit 0
fi

PR_NUMBER="$(jq -r '.number // empty' <<< "$PR_JSON")"
BUMP_TYPE="$(jq -r '[(.labels // [])[] | .name] | map(select(startswith("bump:"))) | map(sub("bump:"; "")) | map({name: ., weight: (if . == "major" then 3 elif . == "minor" then 2 else 1 end)}) | sort_by(.weight) | reverse | .[0].name // "major"' <<< "$PR_JSON")"
JSON_COMPACT="$(jq -c '.' <<< "$PR_JSON")"

if [[ -z "$PR_NUMBER" || "$PR_NUMBER" == "null" ]]; then
  echo "PR payload missing number; defaulting to empty PR context"
  PR_NUMBER=""
fi

echo "PR #${PR_NUMBER} — bump: ${BUMP_TYPE}"
echo "pr_number=${PR_NUMBER}" >> "$GITHUB_OUTPUT"
echo "bump_type=${BUMP_TYPE}" >> "$GITHUB_OUTPUT"
echo "json=${JSON_COMPACT//'%'/'%25'}" >> "$GITHUB_OUTPUT"
