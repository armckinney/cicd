# get-pull-request

This document was generated using AI from the action definition in this repository.

Action file: [../../../../.github/actions/github/get-pull-request/action.yaml](../../../../.github/actions/github/get-pull-request/action.yaml)

## Purpose

Resolves the pull request associated with the current branch or commit and derives a semantic version bump type from pull request labels.

## When To Use

Use this when a workflow needs pull request context, including the PR number, the full PR payload, or a `major` / `minor` / `patch` bump decision.

## Usage

```yaml
- name: Get Pull Request
  id: pr
  uses: ./.github/actions/github/get-pull-request

- name: Use PR metadata
  shell: bash
  run: |
    echo "PR: ${{ steps.pr.outputs.pr_number }}"
    echo "Bump: ${{ steps.pr.outputs.bump_type }}"
```

## Inputs

This action does not define any inputs.

## Outputs

| Name | Description |
| --- | --- |
| `pr_number` | Pull request number for the current branch or commit. Empty string if no PR is found. |
| `bump_type` | Semantic version bump derived from PR labels: `major`, `minor`, or `patch`. Defaults to `patch`. |
| `json` | Compact JSON representation of the pull request. Empty string if no PR is found. |

## Notes

- The action uses `github.token` through `GH_TOKEN`, so callers do not need to pass a separate token input.
- The bump type defaults to `patch` when no pull request or matching bump label is found.
- The action reads repository and ref context from the workflow environment, including the current SHA, ref name, repository name, and default branch.
