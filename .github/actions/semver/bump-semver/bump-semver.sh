#!/usr/bin/env bash
set -euo pipefail

LABEL="$PRERELEASE_LABEL"

# Parse numeric core (strip any existing prerelease / build-metadata)
CORE="${VERSION%%-*}"; CORE="${CORE%%+*}"
MAJOR="$(cut -d'.' -f1 <<< "$CORE")"
MINOR="$(cut -d'.' -f2 <<< "$CORE")"
PATCH="$(cut -d'.' -f3 <<< "$CORE")"

_resolve_id() {
  local id="$PRERELEASE_ID"

  # Default to run number if not provided
  if [[ -z "$id" ]]; then
    echo "${GITHUB_RUN_NUMBER:-0}"
    return
  fi

  # Check if input contains newlines or is a single existing file path
  if echo "$id" | grep -q $'\n' || [[ -f "$id" ]]; then
    # Hash all provided file paths together
    local combined_hash
    combined_hash="$(echo "$id" | while IFS= read -r filepath; do
      [[ -z "$filepath" ]] && continue
      if [[ -f "$filepath" ]]; then
        sha256sum "$filepath"
      else
        echo "::warning::prerelease_id file not found: $filepath"
      fi
    done | sha256sum | cut -c1-8)"
    echo "$combined_hash"
  else
    # Verbatim integer or alphanumeric string
    echo "$id"
  fi
}

case "$BUMP" in
  major)      NEW="$((MAJOR+1)).0.0" ;;
  minor)      NEW="${MAJOR}.$((MINOR+1)).0" ;;
  patch)      NEW="${MAJOR}.${MINOR}.$((PATCH+1))" ;;
  prerelease) NEW="${MAJOR}.${MINOR}.$((PATCH+1))" ;;
  *)
    echo "::error::Invalid bump '$BUMP'. Must be: major | minor | patch | prerelease"
    exit 1
    ;;
esac

# Append prerelease suffix if label is provided (id always resolved, defaults to run number)
if [[ -n "$LABEL" ]]; then
  ID_SUFFIX="$(_resolve_id)"
  NEW="${NEW}${LABEL}${ID_SUFFIX}"
elif [[ -n "$PRERELEASE_ID" ]]; then
  ID_SUFFIX="$(_resolve_id)"
  NEW="${NEW}-${ID_SUFFIX}"
fi

echo "Base version : $VERSION"
echo "Bump type    : $BUMP"
echo "New version  : $NEW"
echo "version=$NEW" >> "$GITHUB_OUTPUT"
