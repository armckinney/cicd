# push-tags

This document describes the local composite action to create and push version tags.

Action file: [../../../../.github/actions/verge/push-tags/action.yaml](../../../../.github/actions/verge/push-tags/action.yaml)

## Purpose

Creates and pushes an exact version tag and, when appropriate, related floating tags for the current commit.

## When To Use

Use this when a workflow has already computed the target version and needs to publish git tags such as the exact version tag, major and minor floating tags, and `latest`.

## Usage

```yaml
- name: Push tags
  id: tags
  uses: ./.github/actions/verge/push-tags
  with:
    version: v1.2.3

- name: Show pushed tags
  shell: bash
  run: echo "${{ steps.tags.outputs.tags }}"
```

## Inputs

| Name | Required | Default | Description |
| --- | --- | --- | --- |
| `version` | Yes | none | Exact version tag to create (e.g. `1.2.3` or `v1.2.3`). |
| `push_floating_tags` | No | `auto` | Controls whether floating tags are created. In `auto` mode, stable versions also push `vMAJOR`, `vMAJOR.MINOR`, and `latest`, while prerelease versions push only the exact tag. Set to `false` to always skip floating tags. |

## Outputs

| Name | Description |
| --- | --- |
| `tags` | Space-separated list of all tags pushed by the action. |

## Notes

- Stable releases can update floating tags by force-pushing them to the current commit.
- Prerelease versions skip floating tags when `push_floating_tags` is left at `auto`.
- Callers need repository write permission for tags, typically via `contents: write`.
