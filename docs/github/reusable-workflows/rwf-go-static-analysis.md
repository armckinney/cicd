# rwf-go-static-analysis

This document describes the Go static analysis reusable workflow.

Reusable workflow file: [../../../.github/workflows/rwf-go-static-analysis.yaml](../../../.github/workflows/rwf-go-static-analysis.yaml)

## Purpose

Runs static analysis and lint checks using `golangci-lint` to maintain Go code quality and standard adherence.

## When To Use

Use this in Go pull request checks and CI runs.

## Usage

```yaml
jobs:
  go-static-analysis:
    uses: ./.github/workflows/rwf-go-static-analysis.yaml
    with:
      working_directory: tests/go/example
      go_version: '1.22'
```

## Inputs

| Name | Required | Default | Description |
| --- | --- | --- | --- |
| `working_directory` | No | `.` | Directory where Go code is located. |
| `go_version` | No | empty string | The Go version to install. Defaults to reading from `go.mod`. |
| `golangci_lint_version` | No | `v1.60` | Version of `golangci-lint` to use. |

## Secrets

This workflow does not define any `workflow_call` secrets.

## Outputs

This workflow does not publish outputs.

## What It Runs

- Sets up Go environment via [setup action](../actions/go/setup.md).
- Runs `golangci-lint` via [lint action](../actions/go/lint.md).

## Notes

- The bundled caller example is [../../../.github/workflows/wf-go-cicd.yaml](../../../.github/workflows/wf-go-cicd.yaml).
