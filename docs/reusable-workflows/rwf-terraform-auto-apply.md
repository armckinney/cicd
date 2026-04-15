# rwf-terraform-auto-apply

This document was generated using AI from the reusable workflow definition in this repository.

Reusable workflow file: [../../.github/workflows/rwf-terraform-auto-apply.yaml](../../.github/workflows/rwf-terraform-auto-apply.yaml)

## Purpose

Runs `terraform init` and `terraform apply` for one configuration and one environment without binding the job to a GitHub environment.

## When To Use

Use this when you want the same apply behavior as `rwf-terraform-apply` but do not want a repository environment gate on the job.

## Usage

```yaml
jobs:
  terraform-auto-apply:
    uses: ./.github/workflows/rwf-terraform-auto-apply.yaml
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
| `environment` | Yes | none | Environment name used for both `.tfbackend` and `.tfvars` files. |
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

- This workflow currently has no bundled caller in `.github/workflows`.
- Compared with `rwf-terraform-apply`, the job does not set `environment: ${{ inputs.environment }}`.
- The configuration is expected to contain `env/<environment>.tfbackend` and `env/<environment>.tfvars`.