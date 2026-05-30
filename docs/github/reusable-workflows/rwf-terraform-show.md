# rwf-terraform-show

This document was generated using AI from the reusable workflow definition in this repository.

Reusable workflow file: [../../../.github/workflows/rwf-terraform-show.yaml](../../../.github/workflows/rwf-terraform-show.yaml)

## Purpose

Runs `terraform init` and `terraform show` for one configuration and one environment.

## When To Use

Use this for ad hoc inspection of the current Terraform state from a controlled workflow entry point.

## Usage

```yaml
jobs:
  terraform-show:
    uses: ./.github/workflows/rwf-terraform-show.yaml
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
| `environment` | Yes | none | Environment name used for backend and vars. |
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

## Notes

- The configuration is expected to contain `env/<environment>.tfbackend`.
- This workflow only shows state; it does not run static analysis or planning by itself.
- The bundled caller example is [../../../.github/workflows/wf-terraform-show.yaml](../../../.github/workflows/wf-terraform-show.yaml).