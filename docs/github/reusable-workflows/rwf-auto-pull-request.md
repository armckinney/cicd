# rwf-auto-pull-request

This document was generated using AI from the reusable workflow definition in this repository.

Reusable workflow file: [../../../.github/workflows/rwf-auto-pull-request.yaml](../../../.github/workflows/rwf-auto-pull-request.yaml)

## Purpose

Creates a pull request when an issue is assigned and closes the matching pull request when the issue is closed.

## When To Use

Use this when you want issue assignment to automatically open a working branch and pull request for the assignee.

## Usage

```yaml
name: auto-pull-request

on:
  issues:
    types: [assigned, closed]

jobs:
  auto-pull-request:
    uses: ./.github/workflows/rwf-auto-pull-request.yaml
```

If you are calling this workflow from another repository, replace the local `uses` path with `owner/repo/.github/workflows/rwf-auto-pull-request.yaml@ref`.

## Inputs

This workflow does not define any `workflow_call` inputs.

## Secrets

This workflow does not define any `workflow_call` secrets.

## Outputs

This workflow does not publish outputs.

## Notes

- The workflow expects issue events, specifically `assigned` and `closed`.
- The branch and pull request title are derived from `<issue-number>-<issue-title>` with spaces replaced by `-`.
- The create path writes a file under `.github/autopr/`, so that directory needs to exist in the repository.
- The bundled caller example is [../../../.github/workflows/wf-auto-pull-request.yaml](../../../.github/workflows/wf-auto-pull-request.yaml).