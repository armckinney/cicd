# prune-tags

This document describes the local composite action to safely prune git tags and GitHub Releases.

Action file: [../../../../.github/actions/github/prune-tags/action.yaml](../../../../.github/actions/github/prune-tags/action.yaml)

## Purpose

Atomicly deletes remote and local Git tags along with their corresponding GitHub Releases matching a specified prerelease prefix.

## When To Use

Use this action during release cleanup (e.g. promoting a prerelease to a stable production version) to automatically delete all intermediate prerelease tags and GitHub Releases (such as `v1.2.3-dev.1`, `v1.2.3-dev.2`) of the same version line.

## Usage

```yaml
- name: Prune Old Dev Tags
  uses: ./.github/actions/github/prune-tags
  with:
    prerelease_prefix: v1.2.3-dev
    token: ${{ secrets.token || github.token }}
```

## Inputs

| Name | Required | Default | Description |
| --- | --- | --- | --- |
| `prerelease_prefix` | Yes | none | The tag prefix pattern to match and prune (e.g., `v1.2.3-dev` or `1.2.3-alpha`). |
| `token` | No | `${{ github.token }}` | GitHub token with contents write permissions. |

## Notes

- Uses the official GitHub CLI (`gh`) to delete GitHub Releases.
- Performs fallback git deletion commands to clean up the tags even if no release was created.
- Callers must provide a token with `contents: write` permissions.
