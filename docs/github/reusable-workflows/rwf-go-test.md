# rwf-go-test

This document describes the Go unit testing reusable workflow.

Reusable workflow file: [../../../.github/workflows/rwf-go-test.yaml](../../../.github/workflows/rwf-go-test.yaml)

## Purpose

Runs unit and integration tests across Go packages with optional race detection and code coverage file generation.

## When To Use

Use this in Go pull request checks and CI runs alongside static analysis.

## Usage

```yaml
jobs:
  go-test:
    uses: ./.github/workflows/rwf-go-test.yaml
    with:
      working_directory: tests/go/example
      go_version: '1.22'
      race: true
      coverage: true
```

## Inputs

| Name | Required | Default | Description |
| --- | --- | --- | --- |
| `working_directory` | No | `.` | Directory where Go code is located. |
| `go_version` | No | empty string | The Go version to install. Defaults to reading from `go.mod`. |
| `race` | No | `true` | Enable Go race detector (boolean). |
| `coverage` | No | `true` | Enable code coverage profiling and output `coverage.out` (boolean). |
| `packages` | No | `./...` | The Go packages to run tests on. |

## Secrets

This workflow does not define any `workflow_call` secrets.

## Outputs

This workflow does not publish outputs.

## What It Runs

- Sets up Go environment via [setup action](../actions/go/setup.md).
- Runs tests via [test action](../actions/go/test.md).

## Notes

- The bundled caller example is [../../../.github/workflows/wf-go-cicd.yaml](../../../.github/workflows/wf-go-cicd.yaml).
