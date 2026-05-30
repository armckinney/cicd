# rwf-verge-tag

This document describes the generic reusable workflow definition inside this repository, powered by the **Verge CLI**.

Reusable workflow file: [../../../.github/workflows/rwf-verge-tag.yaml](../../../.github/workflows/rwf-verge-tag.yaml)

## Purpose

Calculates the next version using the **Verge CLI** engine and the calling repository's local `.verge.yaml` config, then creates and pushes the computed git tag using standard force-pushes and tag cleanups.

## When To Use

Use this workflow to implement an elegant **Inversion of Control** for your version releases. Instead of hardcoding version-bumping and naming conventions within the GitHub Actions runner, the local source repository maintains absolute control via its `.verge.yaml` file, while the reusable workflow acts purely as a generic runner/orchestrator.

By providing a completely agnostic `verge_arguments` interface, the workflow remains decoupled from Verge CLI's specific options and command-line flags. If Verge CLI introduces new feature flags in the future, calling workflows can utilize them immediately without modifying the reusable pipeline definition.

## Usage

```yaml
jobs:
  tag-version:
    uses: ./.github/workflows/rwf-verge-tag.yaml
    secrets: inherit
    with:
      # No verge_arguments are required by default!
      # On dev branches, it defaults to .verge.yaml configuration (vX.Y.Z-dev.N).
      # On the default branch, it dynamically resolves the bump kind (bump:major|minor|patch) from the merged PR labels.
      prune_dev_tags: ${{ github.ref_name == github.event.repository.default_branch }}
```

## Inputs

| Name | Required | Type | Default | Description |
| --- | --- | --- | --- | --- |
| `verge_arguments` | No | string | empty | Optional raw arguments and flags passed directly to the `verge bump` command (e.g. `--provider-config include_prerelease=false` or `--version 1.0.0`). |
| `prune_dev_tags` | No | boolean | `true` | Whether to prune old intermediate development tags (e.g. `*-dev.*`) upon successful final release promotion. The workflow automatically detects if the calculated tag is a stable release. |

## Secrets

| Name | Required | Description |
| --- | --- | --- |
| `token` | No | GitHub token with `contents: write` permissions. Defaults to `github.token` if omitted. |

## Outputs

| Name | Description |
| --- | --- |
| `version` | Calculated and pushed version string (e.g., `1.2.4` or `v1.2.4-dev.3`). |

## Notes

- The workflow requires `contents: write` permissions to push the generated git tag.
- By default, Verge CLI executes the bump relative to the checked-out workspace's `.verge.yaml`.
- The bundled caller example is [../../../.github/workflows/wf-verge-tag.yaml](../../../.github/workflows/wf-verge-tag.yaml).