# resolve-version

This document was generated using AI from the action definition in this repository.

Action file: [../../../.github/actions/semver/resolve-version/action.yaml](../../../.github/actions/semver/resolve-version/action.yaml)

## Purpose

Finds the latest semantic version from a configured source or returns an explicit override when one is provided.

## When To Use

Use this when a workflow needs a current baseline version before calculating the next release or tag.

## Usage

```yaml
- name: Resolve version
  id: resolve
  uses: ./.github/actions/semver/resolve-version
  with:
    version_source: git_tag

- name: Show version
  shell: bash
  run: echo "${{ steps.resolve.outputs.version }}"
```

## Inputs

| Name | Required | Default | Description |
| --- | --- | --- | --- |
| `version_source` | Yes | none | Source used to resolve the latest version. Supported values are `git_tag`, `ghcr.io/<owner>/<image>`, and `https://github.com/<owner>/<repo>`. |
| `version` | No | empty string | Explicit semantic version override. When set, the action skips source lookup and returns this value. |

## Outputs

| Name | Description |
| --- | --- |
| `version` | Resolved semantic version without a leading `v`, for example `1.2.3`. |

## Notes

- The action uses `github.token` through `GH_TOKEN` when resolving versions from GitHub-based sources.
- `git_tag` expects the repository checkout to include the relevant tags.
- The explicit `version` input is the escape hatch when callers need deterministic behavior without any remote or git lookup.
