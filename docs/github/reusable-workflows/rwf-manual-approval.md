# rwf-manual-approval

This document was generated using AI from the reusable workflow definition in this repository.

Reusable workflow file: [../../../.github/workflows/rwf-manual-approval.yaml](../../../.github/workflows/rwf-manual-approval.yaml)

## Purpose

Adds a manual approval gate by targeting a GitHub repository environment that has required reviewers configured.

## When To Use

Use this before deploy, destroy, or other sensitive jobs where a GitHub environment approval should block execution.

## Usage

```yaml
on:
  workflow_dispatch:
    inputs:
      environment:
        description: Environment for deployment
        required: true
        type: choice
        options: [dev, test, prod]

jobs:
  manual-approval:
    uses: ./.github/workflows/rwf-manual-approval.yaml
    with:
      environment: ${{ inputs.environment }}
      message: Approval needed to proceed
```

## Inputs

| Name | Required | Default | Description |
| --- | --- | --- | --- |
| `environment` | Yes | none | Repository environment name that enforces approval. |
| `message` | No | `Manual approval required to proceed` | Notice text shown in the job log. |

## Secrets

This workflow does not define any `workflow_call` secrets.

## Outputs

This workflow does not publish outputs.

## Notes

- Approval behavior depends on the repository environment configuration, not on logic inside the workflow itself.
- Configure the target environment in the repository settings with required reviewers before using this workflow.
- The bundled caller example is [../../../.github/workflows/wf-manual-approval.yaml](../../../.github/workflows/wf-manual-approval.yaml).