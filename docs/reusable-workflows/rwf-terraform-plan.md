# rwf-terraform-plan

This document was generated using AI from the reusable workflow definition in this repository.

Reusable workflow file: [../../.github/workflows/rwf-terraform-plan.yaml](../../.github/workflows/rwf-terraform-plan.yaml)

## Purpose

Runs `terraform init`, attempts import refresh logic using `.imports.tf`, and then runs `terraform plan`.

## When To Use

Use this before apply to validate the change set for one configuration and environment.

## Usage

```yaml
jobs:
  terraform-plan:
    uses: ./.github/workflows/rwf-terraform-plan.yaml
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

- The workflow temporarily renames `.imports.tf` to `imports.tf`, runs `terraform refresh`, then hides the file again.
- The import refresh step is `continue-on-error: true`, so plan still runs if refresh fails.
- The configuration is expected to contain `env/<environment>.tfbackend` and `env/<environment>.tfvars`.
- The bundled caller examples are [../../.github/workflows/wf-terraform-apply.yaml](../../.github/workflows/wf-terraform-apply.yaml), [../../.github/workflows/wf-terraform-show.yaml](../../.github/workflows/wf-terraform-show.yaml), and the deployment composition workflows.