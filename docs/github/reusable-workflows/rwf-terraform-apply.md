# rwf-terraform-apply

This document was generated using AI from the reusable workflow definition in this repository.

Reusable workflow file: [../../../.github/workflows/rwf-terraform-apply.yaml](../../../.github/workflows/rwf-terraform-apply.yaml)

## Purpose

Runs `terraform init` and `terraform apply` for one configuration and one environment, with the job bound to a matching GitHub environment.

## When To Use

Use this when you want an environment-gated apply step after planning has completed successfully.

## Usage

```yaml
jobs:
  terraform-apply:
    uses: ./.github/workflows/rwf-terraform-apply.yaml
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
| `environment` | Yes | none | Environment name used for both `.tfbackend` and `.tfvars` files and the GitHub environment. |
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

- The job sets `environment: ${{ inputs.environment }}`, so GitHub environment rules apply.
- The configuration is expected to contain `env/<environment>.tfbackend` and `env/<environment>.tfvars`.
- For OIDC-based Azure auth, pass `arm_use_oidc: true` and expose the ARM identity secrets from the caller.
- The bundled caller example is [../../../.github/workflows/wf-terraform-apply.yaml](../../../.github/workflows/wf-terraform-apply.yaml).