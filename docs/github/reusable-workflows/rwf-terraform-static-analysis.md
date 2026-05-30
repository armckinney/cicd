# rwf-terraform-static-analysis

This document was generated using AI from the reusable workflow definition in this repository.

Reusable workflow file: [../../../.github/workflows/rwf-terraform-static-analysis.yaml](../../../.github/workflows/rwf-terraform-static-analysis.yaml)

## Purpose

Runs Terraform static analysis for one configuration: format check, validate, docs check, security scan, and linting.

## When To Use

Use this at the start of a Terraform pipeline to catch formatting, validation, documentation, security, and lint errors before planning or applying.

## Usage

```yaml
jobs:
  terraform-static-analysis:
    uses: ./.github/workflows/rwf-terraform-static-analysis.yaml
    with:
      container_image: ${{ needs.container-build-and-push.outputs.container_image }}
      configuration: example
      environment: dev
```

## Inputs

| Name | Required | Default | Description |
| --- | --- | --- | --- |
| `container_image` | Yes | none | Container image with Terraform, terraform-docs, Trivy, and TFLint installed. |
| `configuration` | Yes | none | Configuration directory under `terraform/configurations/`. |
| `environment` | Yes | none | Environment name used for the lint var file. |

## Secrets

This workflow does not define any `workflow_call` secrets.

## Outputs

This workflow does not publish outputs.

## What It Runs

- `terraform fmt -check`
- `terraform init -backend=false`
- `terraform validate`
- `terraform-docs` output comparison against the configuration README
- `trivy config --severity HIGH,CRITICAL --exit-code 1`
- `tflint --var-file=env/<environment>.tfvars`

## Notes

- The docs check compares generated docs output with the configuration README.
- The bundled caller examples are [../../../.github/workflows/wf-terraform-apply.yaml](../../../.github/workflows/wf-terraform-apply.yaml), [../../../.github/workflows/wf-terraform-show.yaml](../../../.github/workflows/wf-terraform-show.yaml), [../../../.github/workflows/wf-terraform-restate.yaml](../../../.github/workflows/wf-terraform-restate.yaml), and the deployment composition workflows.