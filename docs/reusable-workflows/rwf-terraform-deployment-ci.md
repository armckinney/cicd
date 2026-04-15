# rwf-terraform-deployment-ci

This document was generated using AI from the reusable workflow definition in this repository.

Reusable workflow file: [../../.github/workflows/rwf-terraform-deployment-ci.yaml](../../.github/workflows/rwf-terraform-deployment-ci.yaml)

## Purpose

Runs the standard Terraform deployment pipeline for a single configuration and environment: static analysis, plan, then apply.

## When To Use

Use this as the main reusable entry point for a single-environment Terraform deployment workflow.

## Usage

```yaml
jobs:
  terraform-deployment-ci:
    uses: ./.github/workflows/rwf-terraform-deployment-ci.yaml
    with:
      container_image: ${{ needs.container-build-and-push.outputs.container_image }}
      configuration: example
      environment: dev
      arm_use_oidc: false
    secrets:
      ARM_CLIENT_ID: ${{ secrets.ARM_CLIENT_ID }}
      ARM_SUBSCRIPTION_ID: ${{ secrets.ARM_SUBSCRIPTION_ID }}
      ARM_TENANT_ID: ${{ secrets.ARM_TENANT_ID }}
      ARM_CLIENT_SECRET: ${{ secrets.ARM_CLIENT_SECRET }}
```

## Inputs

| Name | Required | Default | Description |
| --- | --- | --- | --- |
| `container_image` | Yes | none | Container image with Terraform and required CLIs installed. |
| `configuration` | Yes | none | Configuration directory under `terraform/configurations/`. |
| `environment` | Yes | none | Environment name used for backend, vars, and GitHub environment binding. |
| `arm_use_oidc` | No | `false` | Enables Azure provider OIDC environment variable wiring. |

## Secrets

| Name | Required | Description |
| --- | --- | --- |
| `ARM_CLIENT_ID` | No | Azure service principal client ID. |
| `ARM_SUBSCRIPTION_ID` | No | Azure subscription ID. |
| `ARM_TENANT_ID` | No | Azure tenant ID. |
| `ARM_CLIENT_SECRET` | No | Azure service principal client secret. |

## Outputs

This workflow does not publish outputs.

## What It Runs

1. `rwf-terraform-static-analysis`
2. `rwf-terraform-plan`
3. `rwf-terraform-apply`

## Notes

- This is a composition workflow that delegates to other Terraform reusable workflows.
- The bundled caller examples are [../../.github/workflows/wf-terraform-ci-example-dev.yaml](../../.github/workflows/wf-terraform-ci-example-dev.yaml) and [../../.github/workflows/wf-terraform-ci-azurerg-dev.yaml](../../.github/workflows/wf-terraform-ci-azurerg-dev.yaml).