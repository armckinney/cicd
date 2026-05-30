# rwf-terraform-restate

This document was generated using AI from the reusable workflow definition in this repository.

Reusable workflow file: [../../../.github/workflows/rwf-terraform-restate.yaml](../../../.github/workflows/rwf-terraform-restate.yaml)

## Purpose

Deletes the current Terraform state file and then rebuilds state by running the import refresh flow.

## When To Use

Use this for state recovery scenarios where the state file is corrupted or needs to be reconstructed from import definitions.

## Usage

```yaml
jobs:
  terraform-restate:
    uses: ./.github/workflows/rwf-terraform-restate.yaml
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
| `environment` | Yes | none | Environment name used for backend, vars, and GitHub environment binding on the delete-state job. |
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

1. Deletes the existing state file from the configured backend.
2. Re-initializes Terraform.
3. Temporarily exposes `.imports.tf` and runs `terraform refresh`.

## Notes

- For a local backend, the workflow deletes the configured local state file.
- For an `azurerm` backend, the workflow attempts to delete the state blob from Azure Storage.
- This is a destructive recovery workflow. Use it only when you intend to recreate state.
- The bundled caller example is [../../../.github/workflows/wf-terraform-restate.yaml](../../../.github/workflows/wf-terraform-restate.yaml).