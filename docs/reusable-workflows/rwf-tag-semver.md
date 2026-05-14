# rwf-tag-semver

This document was generated using AI from the reusable workflow definition in this repository.

Reusable workflow file: [../../.github/workflows/rwf-tag-semver.yaml](../../.github/workflows/rwf-tag-semver.yaml)

## Purpose

Calculates the next semantic version from the latest git tag and pull request metadata, then pushes the new git tag.

## When To Use

Use this when you want repository tags to be managed automatically from pull request bump metadata, including optional prerelease tags on non-default branches.

## Usage

```yaml
jobs:
  tag-semver:
    uses: ./.github/workflows/rwf-tag-semver.yaml
    secrets: inherit
    with:
      prerelease_label: ${{ github.ref_name != github.event.repository.default_branch && 'dev' || '' }}
```

## Inputs

| Name | Required | Default | Description |
| --- | --- | --- | --- |
| `prerelease_label` | No | empty string | Prerelease label appended on non-default branches, for example `dev` or `alpha`. |
| `prerelease_id` | No | empty string | Prerelease identifier appended after the label. Supply an alphanumeric string directly, or newline-separated file paths to hash. If omitted, the workflow defaults to the run number. |

## Secrets

This workflow does not define any `workflow_call` secrets.

## Outputs

| Name | Description |
| --- | --- |
| `version` | Published semantic version without a leading `v`, for example `1.2.4` or `1.2.4pr123dev42`. |

## Notes

- The workflow requires `contents: write` so it can push the generated git tag.
- The version baseline is resolved from existing git tags via the local `resolve-version` action with `version_source: git_tag`.
- The bump type comes from the local `get-pull-request` action, so callers should ensure the event context or repository conventions provide that metadata.
- For prerelease runs, the default suffix format is `pr{prnumber}{prerelease_label}{prerelease_id}`. If no explicit `prerelease_id` is supplied, the run number is used.
- The workflow fetches the full git history (`fetch-depth: 0`) before resolving the latest version.
- The bundled caller example is [../../.github/workflows/wf-tag-semver.yaml](../../.github/workflows/wf-tag-semver.yaml).