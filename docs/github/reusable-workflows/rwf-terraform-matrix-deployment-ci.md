# rwf-terraform-matrix-deployment-ci

This document was generated using AI from the reusable workflow definition in this repository.

Reusable workflow file: [../../../.github/workflows/rwf-terraform-matrix-deployment-ci.yaml](../../../.github/workflows/rwf-terraform-matrix-deployment-ci.yaml)

## Purpose

Runs a Terraform deployment pipeline suitable for a matrix strategy across multiple environments.

## When To Use

Use this from a caller that defines a matrix of environments, typically after a single test environment has already validated the release.

## Usage

```yaml
jobs:
  terraform-matrix-deployment-ci:
    uses: ./.github/workflows/rwf-terraform-matrix-deployment-ci.yaml
    strategy:
      matrix:
        environment: [dev, test, prod]
    with:
      container_image: ${{ needs.container-build-and-push.outputs.container_image }}
      configuration: example
      environment: ${{ matrix.environment }}
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
| `environment` | Yes | none | Environment name passed from the matrix entry. |
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

1. Inline `tflint`
2. `rwf-terraform-plan`
3. `rwf-terraform-apply`

## Notes

- The caller is responsible for defining the matrix strategy.
- The bundled caller example is [../../../.github/workflows/wf-terraform-ci-release.yaml](../../../.github/workflows/wf-terraform-ci-release.yaml).
- This workflow does not run the full static-analysis suite; it only performs linting before plan and apply.