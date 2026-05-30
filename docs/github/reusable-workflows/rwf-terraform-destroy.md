# rwf-terraform-destroy

This document was generated using AI from the reusable workflow definition in this repository.

Reusable workflow file: [../../../.github/workflows/rwf-terraform-destroy.yaml](../../../.github/workflows/rwf-terraform-destroy.yaml)

## Purpose

Runs `terraform init` and `terraform destroy` for one configuration and one environment, with the job bound to a matching GitHub environment.

## When To Use

Use this for controlled teardown workflows where GitHub environment protections should still apply.

## Usage

```yaml
jobs:
  terraform-destroy:
    uses: ./.github/workflows/rwf-terraform-destroy.yaml
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

## Notes

- The job sets `environment: ${{ inputs.environment }}`, so environment approvals and protection rules can be applied.
- The configuration is expected to contain `env/<environment>.tfbackend` and `env/<environment>.tfvars`.
- Pair this with a manual approval or separate dispatch workflow if destroy should never run automatically.