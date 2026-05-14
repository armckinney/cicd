# bump-semver

This document was generated using AI from the action definition in this repository.

Action file: [../../../.github/actions/semver/bump-semver/action.yaml](../../../.github/actions/semver/bump-semver/action.yaml)

## Purpose

Increments a semantic version string and returns the bumped version.

## When To Use

Use this when a workflow already knows the current version and needs to produce the next `major`, `minor`, `patch`, or prerelease version.

## Usage

```yaml
- name: Bump version
  id: bump
  uses: ./.github/actions/semver/bump-semver
  with:
    version: 1.2.3
    bump: patch

- name: Show version
  shell: bash
  run: echo "${{ steps.bump.outputs.version }}"
```

## Inputs

| Name | Required | Default | Description |
| --- | --- | --- | --- |
| `version` | Yes | none | Base semantic version without a leading `v`, for example `1.2.3`. |
| `bump` | Yes | none | Component to increment: `major`, `minor`, `patch`, or `prerelease`. |
| `prerelease_label` | No | `pre` | Label used for prerelease bumps. Accepts values such as `dev`, `alpha`, or `-beta`. |
| `prerelease_id` | No | empty string | Identifier appended after the prerelease label. Can be an explicit string, a single file path to hash, or newline-separated file paths to hash together. When omitted, the action defaults to the workflow run number. |

## Outputs

| Name | Description |
| --- | --- |
| `version` | Bumped semantic version without a leading `v`, for example `1.2.4` or `1.2.4-alpha.7`. |

## Notes

- This action is pure version computation; it does not create tags or releases.
- File-based `prerelease_id` values are hashed and shortened, which is useful when you want prerelease identifiers tied to artifact or dependency contents.
- The action is used by the repository's semver tagging workflow together with `resolve-version` and `push-tags`.
