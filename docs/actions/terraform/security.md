# security

This document describes the local composite action to perform a security scan on Terraform configurations.

Action file: [../../../.github/actions/terraform/security/action.yaml](../../../.github/actions/terraform/security/action.yaml)

## Purpose

Performs static vulnerability and security misconfiguration analysis of Terraform configurations using Trivy.

## When To Use

Use this action in static analysis jobs to prevent high or critical security misconfigurations from being merged.

## Usage

```yaml
- name: Terraform security scan
  uses: ./.github/actions/terraform/security
  with:
    configuration: example
```

## Inputs

| Name | Required | Default | Description |
| --- | --- | --- | --- |
| `configuration` | Yes | - | Name of the configuration. |

## Notes

- Runs `trivy config --tf-exclude-downloaded-modules --severity HIGH,CRITICAL --exit-code 1 terraform/configurations/<configuration>`.
- Fails the build step if security issues with a severity of `HIGH` or `CRITICAL` are detected.
